class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    if params[:client_id].present?
      @activity.client_id = params[:client_id]
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    if params[:activity][:outcome].present? || params[:activity][:reason].present? || params[:activity][:notes].present?
      @outcome = ActivityOutcome.new(activity_outcome_params)
      if @outcome.save
        @activity.outcome_id = @outcome.id
      end
    end

    respond_to do |format|
      if @activity.save
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
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
    if @activity.outcome_id.nil? && (params[:activity][:outcome].present? || params[:activity][:reason].present? || params[:activity][:notes].present?)
      @outcome = ActivityOutcome.new(activity_outcome_params)
      if @outcome.save
        @activity.outcome_id = @outcome.id
      end
    else
      @outcome = ActivityOutcome.find(@activity.outcome_id)
      @outcome.update(activity_outcome_params)
    end
    respond_to do |format|
      if @activity.update(activity_params)
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
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
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'activities'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:activity_type, :engagement_type, :client_id, :rep_id, :annual_value, :status, :date_opened, :date_closed, :other_notes, :outcome_id)
    end
    def activity_outcome_params
      params.require(:activity).permit(:outcome, :reason, :notes)
    end
end
