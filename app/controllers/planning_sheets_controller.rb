class PlanningSheetsController < ApplicationController
  before_action :set_planning_sheet, only: [:index, :show, :edit, :update, :destroy]

  # GET /planning_sheets
  # GET /planning_sheets.json
  def index
    @planning_sheets = PlanningSheet.where(:active => true).order("updated_at DESC")
  end

  def list
    @planning_sheets = PlanningSheet.where(:active => true)
  end

  # GET /planning_sheets/1
  # GET /planning_sheets/1.json
  def show
  end

  # GET /planning_sheets/new
  def new
    @planning_sheet = PlanningSheet.new
  end

  # GET /planning_sheets/1/edit
  def edit
  end

  # POST /planning_sheets
  # POST /planning_sheets.json
  def create
    @planning_sheet = PlanningSheet.new(planning_sheet_params)

    respond_to do |format|
      if @planning_sheet.save
        format.html { redirect_to planning_sheets_path, notice: 'Planning sheet was successfully created.' }
        format.json { render :show, status: :created, location: @planning_sheet }
      else
        format.html { render :new }
        format.json { render json: @planning_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planning_sheets/1
  # PATCH/PUT /planning_sheets/1.json
  def update
    respond_to do |format|
      if @planning_sheet.update(planning_sheet_params)
        format.html { redirect_to planning_sheets_path, notice: 'Planning sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @planning_sheet }
      else
        format.html { render :edit }
        format.json { render json: @planning_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planning_sheets/1
  # DELETE /planning_sheets/1.json
  def destroy
    @planning_sheet.destroy
    respond_to do |format|
      format.html { redirect_to planning_sheets_path, notice: 'Planning sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planning_sheet
      if params[:id]
        @planning_sheet = PlanningSheet.find(params[:id])
      else
        @planning_sheet = PlanningSheet.last
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planning_sheet_params
      params.require(:planning_sheet).permit(:sheet_url, :sheet_name, :created_by)
    end
end
