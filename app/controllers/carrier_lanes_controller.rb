class CarrierLanesController < ApplicationController
  before_action :set_carrier_lane, only: [:show, :edit, :update, :destroy]

  # GET /carrier_lanes
  # GET /carrier_lanes.json
  def index
    @carrier_lanes = CarrierLane.all
  end

  # GET /carrier_lanes/1
  # GET /carrier_lanes/1.json
  def show
  end

  # GET /carrier_lanes/new
  def new
    @carrier_lane = CarrierLane.new
    if params[:carrier_id].present?
      @carrier_lane.carrier_id = params[:carrier_id]
    end
  end

  # GET /carrier_lanes/1/edit
  def edit
  end

  # POST /carrier_lanes
  # POST /carrier_lanes.json
  def create
    @carrier_lane = CarrierLane.new(carrier_lane_params)
    respond_to do |format|
      if @carrier_lane.save
        format.html { redirect_to carrier_path(:id => @carrier_lane.carrier_id), notice: 'Carrier lane was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_lane }
      else
        format.html { render :new }
        format.json { render json: @carrier_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_lanes/1
  # PATCH/PUT /carrier_lanes/1.json
  def update
    respond_to do |format|
      if @carrier_lane.update(carrier_lane_params)
        format.html { redirect_to carrier_path(:id => @carrier_lane.carrier_id), notice: 'Carrier lane was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_lane }
      else
        format.html { render :edit }
        format.json { render json: @carrier_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_lanes/1
  # DELETE /carrier_lanes/1.json
  def destroy
    @carrier_lane.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_lane.carrier_id), notice: 'Carrier lane was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_lane
      @carrier_lane = CarrierLane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_lane_params
      params[:carrier_lane][:lane_origin] = convert_array(params[:carrier_lane][:lane_origin])
      params[:carrier_lane][:lane_destination] = convert_array(params[:carrier_lane][:lane_destination])
      params[:carrier_lane][:commodities] = convert_array(params[:carrier_lane][:commodities])
      params[:carrier_lane][:preferred_load_day] = params[:carrier_lane][:preferred_load_day].to_s.tr('[]', '').tr('"', '').tr(' ', '')[1..-1].to_s
      params.require(:carrier_lane).permit(:lane_priority, :lane_origin, :lane_destination, :truck_per_week, :preferred_load_day, :notes, :carrier_id, :prefer_team, :commodities)
    end
end
