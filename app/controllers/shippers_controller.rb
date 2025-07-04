class ShippersController < ApplicationController
  before_action :set_shipper, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /shippers
  # GET /shippers.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ShipperDatatable.new(params, user: current_user, view_context: view_context) }
    end
  end

  # GET /shippers/1
  # GET /shippers/1.json
  def show
  end

  # GET /shippers/new
  def new
    @shipper = Shipper.new
    if user_signed_in?
      if current_user.ro
        @shipper.relationship_owner = current_user.id
      end
    end
    authorize @shipper
  end

  # GET /shippers/1/edit
  def edit
  end

  # POST /shippers
  # POST /shippers.json
  def create
    @shipper = Shipper.new(shipper_params)
    respond_to do |format|
      if @shipper.save
        save_location
        save_attachment_file
        format.html { redirect_to @shipper, notice: 'Shipper was successfully created.' }
        format.json { render :show, status: :created, location: @shipper }
      else
        format.html { render :new }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shippers/1
  # PATCH/PUT /shippers/1.json
  def update
    respond_to do |format|
      if params[:shipper][:attachment_only].present?
        if params[:shipper][:attachment_file].present?
          @shipper.attachment_file.attach(params[:shipper][:attachment_file])
          @shipper.update_attributes!(audit_comment: "Attachment")
        end
        format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        if @shipper.update(shipper_params)
          save_location
          save_attachment_file
          format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
          format.json { render :show, status: :ok, location: @shipper }
        else
          format.html { render :edit }
          format.json { render json: @shipper.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /shippers/1
  # DELETE /shippers/1.json
  def destroy
    @shipper.destroy
    respond_to do |format|
      format.html { redirect_to shippers_url, notice: 'Shipper was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def origins
    if  params[:shipper_id].present?
      shipper = Shipper.find(params[:shipper_id])
      render json: {:shipper_id => shipper.id, :origins => shipper.origin}
    else
      render json: {:shipper_id => nil, :origins => nil}
    end

  end

  def remove_attachment
    respond_to do |format|
      if @shipper.attachment_file.find(params[:attachment_id]).purge
        format.html { redirect_to shipper_path(:id => @shipper.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        format.html { redirect_to shipper_path(:id => @shipper.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  def compose_mail
    check_ids
    contacts = Shipper.where("shippers.id IN (#{@ids})").pluck("contacts.email").join(",")
    render 'global_pages/mail_form', :layout => 'mail'
  end

  def send_mail
    attachment_files = params[:file].present? ? params[:file] : nil
    save_mail
    SendComposeMailJob.perform_now(params[:to], nil, nil, params[:subject], params[:content_body], current_user.email, @mail.id, attachment_files)
    if params[:record_activity].present?
      if params[:ids].present? && !params[:ids].blank?
        Shipper.where("shippers.id IN (#{params[:ids]})").each do |shipper|
          Activity.create(:shipper_id => shipper.id, :campaign_name => "Email: #{params[:subject]}", :activity_type => "Email", :shipper_contact_id => shipper.poc_id, :other_notes => params[:content_body], :date_opened => Date.today)
        end
      end
    end
    redirect_to shippers_path, notice: 'Mail was successfully sent to shipper/s.'
  end

  def compose_sms
    check_ids
    @phone_numbers = []
    @contacts = Shipper.where("shippers.id IN (#{@ids})").where("primary_eligible_texting = '1' OR secondary_phone_type = '1'")
    @contacts.each do |contact|
      if contact.primary_eligible_texting && contact.primary_phone_type == "Cell"
        @phone_numbers.push(contact.primary_phone)
      elsif contact.secondary_eligible_texting && contact.secondary_phone_type == "Cell"
        @phone_numbers.push(contact.secondary_phone)
      end
    end
    @phone_numbers = @phone_numbers.join(",")
    render 'global_pages/sms_form', :layout => 'mail'
  end

  def send_sms
    SendSmsJob.perform_now(params[:to], params[:content_body])
    save_sms
    if params[:record_activity].present?
      if params[:ids].present? && !params[:ids].blank?
        Shipper.where("shippers.id IN (#{params[:ids]})").each do |shipper|
          Activity.create(:shipper_id => shipper.id, :campaign_name => "Text", :activity_type => "Text", :shipper_contact_id => shipper.poc_id, :other_notes => params[:content_body], :date_opened => Date.today)
        end
      end
    end
    redirect_to shippers_path, notice: 'SMS was successfully sent to shipper/s.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      @shipper = Shipper.find(params[:id])
      authorize @shipper
    end

    def save_location
      if @shipper.location.nil?
        @location = ShipperLocation.new(location_params)
        @location.shipper_id = @shipper.id
        if @location.save
          @shipper.update_attributes(:head_office => @location.id)
        end
      else
        @shipper.location.update_attributes(location_params)
      end
    end

    def save_attachment_file
      if params[:shipper][:attachment_file].present?
        @shipper.attachment_file.attach(params[:shipper][:attachment_file])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_params
      params[:shipper][:shipper_type] = convert_array(params[:shipper][:shipper_type])
      params[:shipper][:commodities] = convert_array(params[:shipper][:commodities])
      params.require(:shipper).permit(:relationship_owner, :company_name, :shipper_id, :parent_id, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :shipper_type, :control_freight, :loads_per_month, :spend_per_year, :commodities, :commodities_notes, :blue_book_score, :blue_book_url, :buying_criteria, :works_with_brokers, :price_sensitivity, :challenges, :current_carrier_mix, :prefer_teams, :years_in_business, :years_established, :complete_record, :website, :linkedin, :last_contact, :last_contact_by, :load_last_month, :load_last_6_month, :loads_per_month, :approved)
    end

    def location_params
      params[:shipper][:is_origin] = params[:origin].present?
      params[:shipper][:is_destination] = params[:destination].present?
      params[:shipper][:name] = params[:shipper][:location_name]
      params.require(:shipper).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end

    def save_mail
      @mail = Mailing.new
      @mail.recipient = params[:to]
      @mail.sender = current_user.email
      @mail.subject = params[:subject]
      @mail.content_body = params[:content_body]
      @mail.user_id = current_user.id
      @mail.sent = true
      if @mail.save
        if params[:file].present?
          @mail.attachment_files.attach(params[:file])
        end
      end
    end

    def save_sms
      sms = Message.new
      sms.recipient = params[:to]
      sms.content_body = params[:content_body]
      sms.user_id = current_user.id
      sms.sent = true
      sms.save
    end

    def check_ids
      ids = params[:ids].split(',').map { |id| id.tr('<input type=\"checkbox\" name=\"shippers[]\" id=\"shippers_\" value=\"', '').tr('\" />', '') }
      filtered_ids = []

      ids.each do |id|
        if id && id != " "
          filtered_ids.push(id.to_i)
        end
      end

      @ids = filtered_ids.join(',')
    end
end
