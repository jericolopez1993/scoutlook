class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /carriers
  # GET /carriers.json
  def index
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    else
      @carrier_categories = current_user.carrier_categories_to_array
      @carriers = []
      begin
        if current_user.has_role?(:admin)
          @carriers = Carrier.all
          authorize @carriers
        elsif current_user.has_role?(:steward) || current_user.ro || current_user.cs
          @carriers = Carrier.where("relationship_owner = ? OR carrier_setup = ?", current_user.id, current_user.id)
          authorize @carriers
        elsif current_user.has_role?(:contact)
          begin
            @carrier = Carrier.find(current_user.carrier_contact.carrier.id)
            redirect_to @carrier
          rescue
            @carriers = []
          end
        end
      rescue
        @carriers = []
      end
    end
  end

  # GET /carriers/1
  # GET /carriers/1.json
  def show
    audits = get_audits(@carrier, nil)
    puts "#{audits.to_json}"
  end

  # GET /carriers/new
  def new
    @carrier = Carrier.new
    begin
      if current_user.ro
        @carrier.relationship_owner = current_user.id
      end
      if current_user.cs
        @carrier.carrier_setup = current_user.id
      end
    rescue
    end
    authorize @carrier
  end

  # GET /carriers/1/edit
  def edit
  end

  # POST /carriers
  # POST /carriers.json
  def create
    @carrier = Carrier.new(carrier_params)
    respond_to do |format|
      if @carrier.save
        @location = CarrierLocation.new(location_params)
        @location.carrier_id = @carrier.id
        if @location.save
          @carrier.update_attributes(:head_office => @location.id)
        end
        if params[:carrier][:attachment_file].present?
          @carrier.attachment_file.attach(params[:carrier][:attachment_file])
        end

        format.html { redirect_to @carrier, notice: 'Carrier was successfully created.' }
        format.json { render :show, status: :created, location: @carrier }
      else
        format.html { render :new }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carriers/1
  # PATCH/PUT /carriers/1.json
  def update
    respond_to do |format|
      if params[:carrier][:attachment_only].present?
        if params[:carrier][:attachment_file].present?
          @carrier.attachment_file.attach(params[:carrier][:attachment_file])
          @carrier.update_attributes!(audit_comment: "Attachment")
        end
        format.html { redirect_to @carrier, notice: 'Carrier was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier }
      else
        if @carrier.update(carrier_params)
          if @carrier.location.nil?
            @location = CarrierLocation.new(location_params)
            @location.carrier_id = @carrier.id
            if @location.save
              @carrier.update_attributes(:head_office => @location.id)
            end
          else
            @carrier.location.update_attributes(location_params)
          end

          if params[:carrier][:attachment_file].present?
            @carrier.attachment_file.attach(params[:carrier][:attachment_file])
          end
          format.html { redirect_to @carrier, notice: 'Carrier was successfully updated.' }
          format.json { render :show, status: :ok, location: @carrier }
        else
          format.html { render :edit }
          format.json { render json: @carrier.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # DELETE /carriers/1
  # DELETE /carriers/1.json
  def destroy
    @carrier.destroy
    respond_to do |format|
      format.html { redirect_to carriers_url, notice: 'Carrier was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def origins
    if  params[:carrier_id].present?
      carrier = Carrier.find(params[:carrier_id])
      render json: {:carrier_id => carrier.id, :origins => carrier.origin}
    else
      render json: {:carrier_id => nil, :origins => nil}
    end

  end

  def remove_attachment
    respond_to do |format|
      if @carrier.attachment_file.find(params[:attachment_id]).purge
        format.html { redirect_to carrier_path(:id => @carrier.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @carrier }
      else
        format.html { redirect_to carrier_path(:id => @carrier.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  def compose_mail
    @ids = params[:ids]
    @contacts = Carrier.where("carriers.id IN (#{@ids})").pluck("carrier_contacts.email").join(",")
    render 'global_pages/mail_form', :layout => 'mail'
  end

  def send_mail
    attachment_files = params[:file].present? ? params[:file] : nil
    SendComposeMailJob.delay.perform_now(params[:to], nil, nil, params[:subject], params[:content_body], current_user.email, attachment_files)
    if params[:record_activity].present?
      if params[:ids].present? && !params[:ids].blank?
        Carrier.where("carriers.id IN (#{params[:ids]})").each do |carrier|
          Activity.create(:carrier_id => carrier.id, :campaign_name => "Email: #{params[:subject]}", :activity_type => "Email", :carrier_contact_id => carrier.poc_id, :other_notes => params[:content_body], :date_opened => Date.today)
        end
      end
    end
    redirect_to carriers_path, notice: 'Mail was successfully sent to carrier/s.'
  end

  def compose_sms
    @ids = params[:ids]
    @phone_numbers = []
    @carrier_contact_ids = Carrier.where("carriers.id IN (#{@ids})").distinct("poc_id").pluck("poc_id").join(",")
    @contacts = CarrierContact.where("id IN (#{@carrier_contact_ids})").where("primary_eligible_texting = '1' OR secondary_phone_type = '1'")
    puts "#{@contacts.to_json}"
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
    SendSmsJob.delay.perform_now(params[:to], params[:content_body])
    if params[:record_activity].present?
      if params[:ids].present? && !params[:ids].blank?
        Carrier.where("carriers.id IN (#{params[:ids]})").each do |carrier|
          Activity.create(:carrier_id => carrier.id, :campaign_name => "Text", :activity_type => "Text", :carrier_contact_id => carrier.poc_id, :other_notes => params[:content_body], :date_opened => Date.today)
        end
      end
    end
    redirect_to carriers_path, notice: 'SMS was successfully sent to carrier/s.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier
      @carrier = Carrier.find(params[:id])
      authorize @carrier
    end

    # Never trust parameters fr om the scary internet, only allow the white list through.
    def carrier_params
      params.require(:carrier).permit(:relationship_owner, :carrier_setup, :company_name, :carrier_id, :parent_id, :category, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :score_card, :freight_guard, :years_in_business, :years_established, :owner_operators, :reefers, :dry_vans, :flat_beds, :teams, :contract_rates, :find_loads, :complete_record, :total_fleet_size, :website, :linkedin, :last_contact, :last_contact_by, :power_units, :company_drivers, :load_last_month, :load_last_6_month, :approved, :mc_number, :last_load_date)
    end

    def location_params
      params[:carrier][:is_origin] = params[:origin].present?
      params[:carrier][:is_destination] = params[:destination].present?
      params[:carrier][:name] = params[:carrier][:location_name]
      params.require(:carrier).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end
end
