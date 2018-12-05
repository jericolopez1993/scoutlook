class CarrierActivitiesController < ApplicationController
  before_action :set_carrier_activity, only: [:show, :edit, :update, :destroy, :remove_attachment]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /carrier_activities
  # GET /carrier_activities.json
  def index
    @carrier_activities = CarrierActivity.all
    authorize @carrier_activities
  end

  # GET /carrier_activities/1
  # GET /carrier_activities/1.json
  def show
  end

  # GET /carrier_activities/new
  def new
    @carrier_activity = CarrierActivity.new
    if params[:carrier_id].present?
      @carrier_activity.carrier_id = params[:carrier_id]
    end
    authorize @carrier_activity
  end

  # GET /carrier_activities/1/edit
  def edit
  end

  # POST /carrier_activities
  # POST /carrier_activities.json
  def create
    @carrier_activity = CarrierActivity.new(carrier_activity_params)
    if params[:carrier_activity][:outcome].present? || params[:carrier_activity][:reason].present? || params[:carrier_activity][:notes].present?
      @outcome = CarrierActivityOutcome.new(carrier_activity_outcome_params)
      if @outcome.save
        @carrier_activity.outcome_id = @outcome.id
      end
    end

    respond_to do |format|
      if @carrier_activity.save
        if params[:carrier_activity][:proposal_pdf].present?
          @carrier_activity.proposal_pdf.attach(params[:carrier_activity][:proposal_pdf])
        end
        if params[:carrier_activity][:credit_application].present?
          @carrier_activity.credit_application.attach(params[:carrier_activity][:credit_application])
        end
        format.html { redirect_to carrier_path(:id => @carrier_activity.carrier_id), notice: 'Carrier Engagement was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_activity }
      else
        format.html { render :new }
        format.json { render json: @carrier_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_activities/1
  # PATCH/PUT /carrier_activities/1.json
  def update
    if @carrier_activity.outcome_id.nil? && (params[:carrier_activity][:outcome].present? || params[:carrier_activity][:reason].present? || params[:carrier_activity][:notes].present?)
      @outcome = CarrierActivityOutcome.new(carrier_activity_outcome_params)
      if @outcome.save
        @carrier_activity.outcome_id = @outcome.id
      end
    else
      begin
        @outcome = CarrierActivityOutcome.find(@carrier_activity.outcome_id)
        @outcome.update(carrier_activity_outcome_params)
      rescue
      end
    end
    respond_to do |format|
      if @carrier_activity.update(carrier_activity_params)
        if params[:carrier_activity][:proposal_pdf].present?
          @carrier_activity.proposal_pdf.attach(params[:carrier_activity][:proposal_pdf])
        end
        if params[:carrier_activity][:credit_application].present?
          @carrier_activity.credit_application.attach(params[:carrier_activity][:credit_application])
        end
        format.html { redirect_to carrier_path(:id => @carrier_activity.carrier_id), notice: 'Carrier Engagement was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_activity }
      else
        format.html { render :edit }
        format.json { render json: @carrier_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_activities/1
  # DELETE /carrier_activities/1.json
  def destroy
    @carrier_activity.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_activity.carrier_id), notice: 'Carrier Engagement was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def quick_create
    @carrier_activity = CarrierActivity.new(carrier_activity_params)
    respond_to do |format|
      if @carrier_activity.save
        if params[:carrier_activity][:proposal_pdf].present?
          @carrier_activity.proposal_pdf.attach(params[:carrier_activity][:proposal_pdf])
        end
        if params[:carrier_activity][:credit_application].present?
          @carrier_activity.credit_application.attach(params[:carrier_activity][:credit_application])
        end
        format.html { redirect_to authenticated_root_path, notice: 'Carrier Engagement was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_activity }
      else
        format.html { render :new }
        format.json { render json: @carrier_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_attachment
    respond_to do |format|
      if @carrier_activity.proposal_pdf.find(params[:attachment_id]).purge
        format.html { redirect_to carrier_path(:id => carrier.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @carrier_activity }
      else
        format.html { redirect_to carrier_activity_path(:id => @carrier_activity.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @carrier_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_activity
      @carrier_activity = CarrierActivity.find(params[:id])
      authorize @carrier_activity
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'carrier_activities'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_activity_params
      params.require(:carrier_activity).permit(:activity_type, :engagement_type, :carrier_id, :rep_id, :annual_value, :status, :date_opened, :date_closed, :other_notes, :outcome_id)
    end
    def carrier_activity_outcome_params
      params.require(:carrier_activity).permit(:outcome, :reason, :notes)
    end
end
