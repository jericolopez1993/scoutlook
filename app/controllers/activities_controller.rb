class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :remove_attachment, :generate_pdf]
  before_action :set_body, only: [:generate_pdf]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
    authorize @activities
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    if params[:carrier_id].present?
      @activity.carrier_id = params[:carrier_id]
    elsif params[:shipper_id].present?
      @activity.shipper_id = params[:shipper_id]
    end

    authorize @activity
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    respond_to do |format|
      if @activity.save
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        if params[:activity][:previous_params] != "activities"
          if !@activity.carrier.nil?
            format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully created.' }
          elsif !@activity.shipper.nil?
            format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully created.' }
          else
            format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
          end
        else
          format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
        end
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        if params[:activity][:previous_params] != "activities"
          if !@activity.carrier.nil?
            format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully updated.' }
          elsif !@activity.shipper.nil?
            format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully updated.' }
          else
            format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
          end
        else
          format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      if @previous_controller == "carriers"
        format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully removed.' }
      elsif @previous_controller == "shippers"
        format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully removed.' }
      else
        format.html { redirect_to activities_path, notice: 'Activity was successfully removed.' }
      end
      format.json { head :no_content }
    end
  end

  def quick_create
    @activity = Activity.new(activity_params)
    respond_to do |format|
      if @activity.save
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        format.html { redirect_to authenticated_root_path, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_attachment
    respond_to do |format|
      if @activity.proposal_pdf.find(params[:attachment_id]).purge
        format.html { redirect_to carrier_path(:id => carrier.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { redirect_to activity_path(:id => @activity.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_pdf
    require "pdfkit"
    kit = PDFKit.new(@content)
    send_data(kit.to_pdf,filename: "#{@activity.display_select_name}.pdf",type: "application/pdf",)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
      authorize @activity
    end

    def set_body
      @content = "<div style='color: grey;'>" +
                 "<h1 style='text-align: center;color: black;margin-bottom: 100px;'>Scout Logistics</h1>" +
                 "<table style='width: 100%;padding-bottom: 10px;'>" +
                 "<thead> <tr> <th style='text-align: left;color: black;padding-bottom: 5px;'>Owner</th> <th style='text-align: right;color: black;padding-bottom: 5px;'>Status</th> </tr></thead>" +
                 "<tbody> <tr> <td style='text-align: left'>#{@activity.user ? @activity.user.full_name : ''}</td><td style='text-align: right'>#{@activity.status ? 'Open' : 'Closed'}</td></tr></tbody>" +
                 "</table>" +
                 "<table style='width: 100%;padding-bottom: 10px;'>" +
                 " <thead> <tr> <th style='text-align: left;color: black;padding-bottom: 5px;'>Type</th> <th style='text-align: center;color: black;padding-bottom: 5px;'>LPW</th> <th style='text-align: right;color: black;padding-bottom: 5px;'>Annual</th> </tr></thead>" +
                 " <tbody> <tr> <td style='text-align: left'>#{@activity.activity_type}</td><td style='text-align: center'>#{@activity.loads_per_week}</td><td style='text-align: right'>#{@activity.annual_value}</td></tr></tbody>" +
                 "</table>" +
                 "<table style='width: 100%;padding-bottom: 10px;'>" +
                 "<thead> <tr> <th style='text-align: left;color: black;padding-bottom: 5px;'>Open</th> <th style='text-align: center;color: black;padding-bottom: 5px;'>Close</th> <th style='text-align: right;color: black;padding-bottom: 5px;'>Outcome</th> </tr></thead>" +
                 " <tbody> <tr> <td style='text-align: left'>#{convert_date(@activity.date_opened)}</td><td style='text-align: center'>#{convert_date(@activity.date_closed)}</td><td style='text-align: right'>#{@activity.outcome}</td></tr></tbody>" +
                 "</table>" +
                 "<table style='width: 100%;padding-bottom: 10px;'>" +
                 " <thead> <tr> <th style='text-align: left;color: black;padding-bottom: 5px;'>Reason</th> <th style='text-align: right;color: black;padding-bottom: 5px;'>
                 Carrier/Shipper</th> </tr></thead>" +
                 " <tbody> <tr> <td style='text-align: left'>#{!@activity.reason.blank? ? @activity.reason : '<i>None</i>'}</td><td style='text-align: right'>#{@activity.carrier ? @activity.carrier.company_name : (@activity.shipper ? @activity.shipper.company_name : '<i>None</i>')}</td></tr></tbody>" +
                 "</table>" +
                 "<table style='width: 100%;padding-bottom: 10px;'>" +
                 "<thead> <tr> <th style='text-align: left;color: black;padding-bottom: 5px;'>Contact Activity</th> <th style='text-align: center;color: black;padding-bottom: 5px;'>Priority</th> <th style='text-align: center;color: black;padding-bottom: 5px;'>City</th> <th style='text-align: right;color: black;padding-bottom: 5px;'>State</th> </tr></thead>"
      if !@activity.carrier.nil?
        @content = @content + "<tbody><tr><td style='text-align: left'>#{@activity.carrier_contact.nil? ? '<i>None</i>' : @activity.carrier_contact.full_name}</td><td style='text-align: center'>#{@activity.carrier.nil? || @activity.carrier.sales_priority.blank? ? '<i>None</i>' : @activity.carrier.sales_priority}</td><td style='text-align: center'>#{@activity.carrier.nil? || @activity.carrier.head_office_location.nil? ? '<i>None</i>' : @activity.carrier.head_office_location.city}</td><td style='text-align: right'>#{@activity.carrier.nil? || @activity.carrier.head_office_location.nil? ? '<i>None</i>' : @activity.carrier.head_office_location.state}</td></tr></tbody>"
      elsif !@activity.shipper.nil?
        @content = @content + "<tbody><tr><td style='text-align: left'>#{@activity.shipper_contact.nil? ? '<i>None</i>' : @activity.shipper_contact.full_name}</td><td style='text-align: center'>#{@activity.shipper.nil? || @activity.shipper.sales_priority.blank? ? '<i>None</i>' : @activity.shipper.sales_priority}</td><td style='text-align: center'>#{@activity.shipper.nil? || @activity.shipper.head_office_location.nil? ? '<i>None</i>' : @activity.shipper.head_office_location.city}</td><td style='text-align: right'>#{@activity.shipper.nil? || @activity.shipper.head_office_location.nil? ? '<i>None</i>' : @activity.shipper.head_office_location.state}</td></tr></tbody>"
      else
        @content = @content + "<tbody><tr><td></td><td></td><td></td><td></td></tr></tbody>"
      end
      @content = @content + "</table>" +
                 "<div style='margin-top: 100px;'><p><strong>Notes:</strong> #{@activity.notes.nil? ? "<i>None</i>" : @activity.notes.html_safe}</p></div>" +
                 "</div>"
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'activities'
      end

      if @previous_controller == "activities"
        @client_type = params[:client_type]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:outcome, :reason, :reason_other, :notes, :date_stamp, :activity_type, :engagement_type, :carrier_id, :carrier_contact_id, :shipper_id, :shipper_contact_id, :user_id, :annual_value, :loads_per_week, :status, :date_opened, :date_closed, :other_notes, :outcome_id, :campaign_name, :load_numbers)
    end

end
