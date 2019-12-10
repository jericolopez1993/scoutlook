class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /carriers
  # GET /carriers.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: CarrierDatatable.new(params, user: current_user, view_context: view_context) }
    end
  end

  def mine
    respond_to do |format|
      format.html
      format.json { render json: CustomerDatatable.new(params, user: current_user, view_context: view_context) }
    end
  end

  # GET /carriers/1
  # GET /carriers/1.json
  def show
    audits = get_audits(@carrier, nil)
    @loads = DfLoad.listings.where("mc_num = 'MC#{@carrier.mc_number}'").order('ship_date DESC')
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
        if @carrier.notes
          CarrierNote.create(carrier_id: @carrier.id, user_id: current_user.id, notes: @carrier.notes)
        end

        save_interview_form
        save_location
        save_attachment_file

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
        # if current_user.id == @carrier.relationship_owner || params[:carrier][:relationship_owner] == @carrier.relationship_owner.to_s
          if @carrier.notes != carrier_params[:notes]
            p 'NOTE', carrier_params[:notes]
            p CarrierNote.create(carrier_id: @carrier.id, user_id: current_user.id, notes: carrier_params[:notes])
          end

          if @carrier.update(carrier_params)

            save_interview_form
            save_location
            save_attachment_file

            format.html { redirect_to @carrier, notice: 'Carrier was successfully updated.' }
            format.json { render :show, status: :ok, location: @carrier }
          else
            format.html { render :edit }
            format.json { render json: @carrier.errors, status: :unprocessable_entity }
          end
        # else
        #   format.html { redirect_to edit_carrier_path(@carrier), notice: "You are not authorize to change the carrier's ownership." }
        # end
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
    @contacts = Carrier.where("carriers.id IN (#{@ids})").pluck("contacts.email").join(",")
    render 'global_pages/mail_form', :layout => 'mail'
  end

  def send_mail
    attachment_files = params[:file].present? ? params[:file] : nil
    save_mail
    SendComposeMailJob.delay.perform_now(params[:to], nil, nil, params[:subject], params[:content_body], current_user.email, @mail.id, attachment_files)
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
    @contacts = Carrier.where("carriers.id IN (#{@ids})").where("primary_eligible_texting = '1' OR secondary_phone_type = '1'")
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
        Carrier.where("carriers.id IN (#{params[:ids]})").each do |carrier|
          Activity.create(:carrier_id => carrier.id, :campaign_name => "Text", :activity_type => "Text", :carrier_contact_id => carrier.poc_id, :other_notes => params[:content_body], :date_opened => Date.today)
        end
      end
    end
    redirect_to carriers_path, notice: 'SMS was successfully sent to carrier/s.'
  end

  def prom
    respond_to do |format|
      format.html
      format.json { render json: CarrPromDatatable.new(params, view_context: view_context) }
    end
  end

  def demo
    respond_to do |format|
      format.html
      format.json { render json: CarrDemoDatatable.new(params, view_context: view_context) }
    end
  end

  def newly
    # render "carriers/carrs/new/index"

    respond_to do |format|
      format.html
      format.json { render json: CarrNewDatatable.new(params, view_context: view_context) }
    end
  end

  def show_merge
    company_name_substring =  params[:company_name]
    if params[:company_name].length > 5
      company_name_substring = params[:company_name][0, 5]
    end
    @duplicate_carriers = Carrier.where("(carriers.mc_number::text ILIKE '%#{params[:mc_number]}%' OR carriers.company_name = ? OR carriers.company_name ILIKE '#{company_name_substring}%' ) AND carriers.id <> ?", params[:company_name], params[:id])
    @all_duplicate_carriers = Carrier.where("(carriers.mc_number::text ILIKE '%#{params[:mc_number]}%' OR carriers.company_name = ? OR carriers.company_name ILIKE '#{company_name_substring}%')", params[:company_name])
    @carrier = Carrier.find(params[:id])
  end

  def merge
    carrier_ids = ""

    if params[:id] && params[:id] != params[:main_carrier_id]
      carrier_ids = "#{params[:id]}"
    end

    if params[:other_carriers]
      if !carrier_ids.blank?
        carrier_ids = "#{carrier_ids}," + convert_array(params[:other_carriers])
      else
        carrier_ids =  convert_array(params[:other_carriers])
      end
    end
    if params[:main_carrier_id] && params[:other_carriers]
      MergeDataServices.new.carrier(params[:main_carrier_id], carrier_ids)
      flash[:notice] = "Successfully Merged Carriers to the Main Carrier."
    else
      flash[:error] = "Please make sure that main carrier and other carriers have data."
    end

    redirect_to carrier_path(:id => params[:main_carrier_id])
  end

  def partial_merged_table
    carrier_ids = params[:id]
    @power_units = 0
    @reefers = 0
    @teams = 0
    @c_mc_latest_date_load_days = 0
    @loads_lw = 0
    @c_mc_latest_date_last_month = 0
    @c_mc_latest_date_last_6_months = 0

    if params[:main_carrier_id]
      carrier_ids = "#{carrier_ids}, #{params[:main_carrier_id]}"
    end

    if params[:other_carrier_ids]
      carrier_ids = "#{carrier_ids}," + params[:other_carrier_ids].to_s.tr('[]', '').tr('"', '').gsub(', ', ',').to_s
    end

    @carriers = Carrier.where("carriers.id IN (#{carrier_ids})")
    @carrier_contacts = CarrierContact.where("carrier_id IN (#{carrier_ids})")
    @carrier_lanes = CarrierLane.where("carrier_id IN (#{carrier_ids})")
    @reminders = Reminder.where("reminders.carrier_id IN (#{carrier_ids})")
    @carrier_notes = CarrierNote.where("carrier_id IN (#{carrier_ids})")
    @loads = DfLoad.listings.where("mc_num IN (#{@carriers.pluck(:mc_number).map { |n| "'#{n}'" }.join(",")})")

    @power_units = @carriers.sum(:power_units)
    @reefers = @carriers.sum(:reefers)
    @teams = @carriers.sum(:teams)
    @c_mc_latest_date_load_days = @carriers.sum(:c_mc_latest_date_load_days)
    @loads_lw = @carriers.sum("carr_new.loads_lw")
    @c_mc_latest_date_last_month = @carriers.sum(:c_mc_latest_date_last_month)
    @c_mc_latest_date_last_6_months = @carriers.sum(:c_mc_latest_date_last_6_months)

    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier
      @carrier = Carrier.find(params[:id])
      authorize @carrier
    end

    def set_carriers
      @carriers = Carrier.all
      latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers)")
      @reefers = (@carriers.sum("carriers.reefers")).round
      @teams = (@carriers.sum("carriers.teams")).round
      @last_month = (latest_date.sum("loadsh_num")).round
      @last_6_months = (latest_date.sum("loadsh_num_6mon")).round

      @my_carriers = Carrier.mine(current_user.id)
      latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers WHERE relationship_owner = #{current_user.id})")
      @my_reefers = (@my_carriers.sum("carriers.reefers")).round
      @my_teams = (@my_carriers.sum("carriers.teams")).round
      @my_last_month = (latest_date.sum("loadsh_num")).round
      @my_last_6_months = (latest_date.sum("loadsh_num_6mon")).round


      mc_number_list = @carriers.pluck(:mc_number)
      @carr_new = CarrNew.where('mcnum NOT IN (?)', mc_number_list)

      authorize @carriers
    end

    def save_interview_form
      if params[:carrier][:interview_attachment_file].present?
        @carrier.interview_attachment_file.attach(params[:carrier][:interview_attachment_file])
      end
      interview = @carrier.interview_attachment_file.attached? || params[:carrier][:interview_attachment_file].present?
      @carrier.update_attributes(:interview =>  interview)
    end

    def save_location
      if @carrier.location.nil?
        @location = CarrierLocation.new(location_params)
        @location.carrier_id = @carrier.id
        if @location.save
          @carrier.update_attributes(:head_office => @location.id)
        end
      else
        @carrier.location.update_attributes(location_params)
      end
    end

    def save_attachment_file
      if params[:carrier][:attachment_file].present?
        @carrier.attachment_file.attach(params[:carrier][:attachment_file])
      end
    end

    # Never trust parameters fr om the scary internet, only allow the white list through.
    def carrier_params
      params.require(:carrier).permit(:relationship_owner, :carrier_setup, :company_name, :carrier_id, :parent_id, :category, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :score_card, :freight_guard, :years_in_business, :years_established, :owner_operators, :reefers, :dry_vans, :flat_beds, :teams, :contract_rates, :find_loads, :complete_record, :total_fleet_size, :website, :linkedin, :last_contact, :last_contact_by, :power_units, :company_drivers, :load_last_month, :load_last_6_month, :approved, :mc_number, :last_load_date, :previous_mc_number, :blacklisted, :wolfbyte)
    end

    def location_params
      params[:carrier][:is_origin] = params[:origin].present?
      params[:carrier][:is_destination] = params[:destination].present?
      params[:carrier][:name] = params[:carrier][:location_name]
      params.require(:carrier).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end

    def save_mail
      @mail = Mailing.new
      @mail.recipient = params[:to].split(',').reject(&:blank?).map(&:to_s).join(', ')
      @mail.sender = current_user.email
      @mail.subject = params[:subject]
      @mail.content_body = params[:content_body]
      @mail.user_id = current_user.id
      @mail.status = "Pending"
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
end
