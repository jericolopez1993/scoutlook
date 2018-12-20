class ShipperActivitiesController < ApplicationController
  before_action :set_shipper_activity, only: [:show, :edit, :update, :destroy, :remove_attachment]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /shipper_activities
  # GET /shipper_activities.json
  def index
    @shipper_activities = ShipperActivity.all
    authorize @shipper_activities
  end

  # GET /shipper_activities/1
  # GET /shipper_activities/1.json
  def show
  end

  # GET /shipper_activities/new
  def new
    @shipper_activity = ShipperActivity.new
    if params[:shipper_id].present?
      @shipper_activity.shipper_id = params[:shipper_id]
    end
    if user_signed_in?
      if current_user.has_role?(:steward) && !current_user.steward.nil?
        @shipper_activity.user_id = current_user.steward.id
      end
    end
    authorize @shipper_activity
  end

  # GET /shipper_activities/1/edit
  def edit
  end

  # POST /shipper_activities
  # POST /shipper_activities.json
  def create
    @shipper_activity = ShipperActivity.new(shipper_activity_params)
    if params[:shipper_activity][:outcome].present? || params[:shipper_activity][:reason].present? || params[:shipper_activity][:notes].present?
      @outcome = ShipperActivityOutcome.new(shipper_activity_outcome_params)
      if @outcome.save
        @shipper_activity.outcome_id = @outcome.id
      end
    end

    respond_to do |format|
      if @shipper_activity.save
        if params[:shipper_activity][:proposal_pdf].present?
          @shipper_activity.proposal_pdf.attach(params[:shipper_activity][:proposal_pdf])
        end
        if params[:shipper_activity][:credit_application].present?
          @shipper_activity.credit_application.attach(params[:shipper_activity][:credit_application])
        end
        format.html { redirect_to shipper_path(:id => @shipper_activity.shipper_id), notice: 'Shipper Engagement was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_activity }
      else
        format.html { render :new }
        format.json { render json: @shipper_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_activities/1
  # PATCH/PUT /shipper_activities/1.json
  def update
    if @shipper_activity.outcome_id.nil? && (params[:shipper_activity][:outcome].present? || params[:shipper_activity][:reason].present? || params[:shipper_activity][:notes].present?)
      @outcome = ShipperActivityOutcome.new(shipper_activity_outcome_params)
      if @outcome.save
        @shipper_activity.outcome_id = @outcome.id
      end
    else
      begin
        @outcome = ShipperActivityOutcome.find(@shipper_activity.outcome_id)
        @outcome.update(shipper_activity_outcome_params)
      rescue
      end
    end
    respond_to do |format|
      if @shipper_activity.update(shipper_activity_params)
        if params[:shipper_activity][:proposal_pdf].present?
          @shipper_activity.proposal_pdf.attach(params[:shipper_activity][:proposal_pdf])
        end
        if params[:shipper_activity][:credit_application].present?
          @shipper_activity.credit_application.attach(params[:shipper_activity][:credit_application])
        end
        format.html { redirect_to shipper_path(:id => @shipper_activity.shipper_id), notice: 'Shipper Engagement was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper_activity }
      else
        format.html { render :edit }
        format.json { render json: @shipper_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_activities/1
  # DELETE /shipper_activities/1.json
  def destroy
    @shipper_activity.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_activity.shipper_id), notice: 'Shipper Engagement was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def quick_create
    @shipper_activity = ShipperActivity.new(shipper_activity_params)
    respond_to do |format|
      if @shipper_activity.save
        if params[:shipper_activity][:proposal_pdf].present?
          @shipper_activity.proposal_pdf.attach(params[:shipper_activity][:proposal_pdf])
        end
        if params[:shipper_activity][:credit_application].present?
          @shipper_activity.credit_application.attach(params[:shipper_activity][:credit_application])
        end
        format.html { redirect_to authenticated_root_path, notice: 'Shipper Engagement was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_activity }
      else
        format.html { render :new }
        format.json { render json: @shipper_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_attachment
    respond_to do |format|
      if @shipper_activity.proposal_pdf.find(params[:attachment_id]).purge
        format.html { redirect_to shipper_path(:id => shipper.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @shipper_activity }
      else
        format.html { redirect_to shipper_activity_path(:id => @shipper_activity.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @shipper_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_activity
      @shipper_activity = ShipperActivity.find(params[:id])
      authorize @shipper_activity
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'shipper_activities'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_activity_params
      if !params[:shipper_activity][:date_stamp].nil? && params[:shipper_activity][:date_stamp] != ''
        params[:shipper_activity][:date_stamp] = Date::strptime(params[:shipper_activity][:date_stamp], "%m/%d/%Y")
      else
        params[:shipper_activity].delete :date_stamp
      end
      params.require(:shipper_activity).permit(:date_stamp, :activity_type, :engagement_type, :shipper_id, :user_id, :annual_value, :status, :date_opened, :date_closed, :other_notes, :outcome_id)
    end
    def shipper_activity_outcome_params
      params.require(:shipper_activity).permit(:outcome, :reason, :notes)
    end
end
