class ActivityOutcomesController < ApplicationController
  before_action :set_activity_outcome, only: [:show, :edit, :update, :destroy]

  # GET /activity_outcomes
  # GET /activity_outcomes.json
  def index
    @activity_outcomes = ActivityOutcome.all
  end

  # GET /activity_outcomes/1
  # GET /activity_outcomes/1.json
  def show
  end

  # GET /activity_outcomes/new
  def new
    @activity_outcome = ActivityOutcome.new
  end

  # GET /activity_outcomes/1/edit
  def edit
  end

  # POST /activity_outcomes
  # POST /activity_outcomes.json
  def create
    @activity_outcome = ActivityOutcome.new(activity_outcome_params)

    respond_to do |format|
      if @activity_outcome.save
        format.html { redirect_to @activity_outcome, notice: 'Activity outcome was successfully created.' }
        format.json { render :show, status: :created, location: @activity_outcome }
      else
        format.html { render :new }
        format.json { render json: @activity_outcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_outcomes/1
  # PATCH/PUT /activity_outcomes/1.json
  def update
    respond_to do |format|
      if @activity_outcome.update(activity_outcome_params)
        format.html { redirect_to @activity_outcome, notice: 'Activity outcome was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_outcome }
      else
        format.html { render :edit }
        format.json { render json: @activity_outcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_outcomes/1
  # DELETE /activity_outcomes/1.json
  def destroy
    @activity_outcome.destroy
    respond_to do |format|
      format.html { redirect_to activity_outcomes_url, notice: 'Activity outcome was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_outcome
      @activity_outcome = ActivityOutcome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_outcome_params
      params.require(:activity_outcome).permit(:outcome, :reason, :notes)
    end
end
