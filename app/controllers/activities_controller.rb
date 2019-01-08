class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :remove_attachment]
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
        if !@activity.carrier.nil?
          format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully created.' }
        elsif !@activity.shipper.nil?
          format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully created.' }
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
        if !@activity.carrier.nil?
          format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully updated.' }
        elsif !@activity.shipper.nil?
          format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
      authorize @activity
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
      if !params[:activity][:date_stamp].nil? && params[:activity][:date_stamp] != ''
        params[:activity][:date_stamp] = Date::strptime(params[:activity][:date_stamp], "%m/%d/%Y")
      else
        params[:activity].delete :date_stamp
      end
      params.require(:activity).permit(:outcome, :reason, :reason_other, :notes, :date_stamp, :activity_type, :engagement_type, :carrier_id, :carrier_contact_id, :shipper_id, :shipper_contact_id, :user_id, :annual_value, :loads_per_week, :status, :date_opened, :date_closed, :other_notes, :outcome_id, :campaign_name)
    end

end
