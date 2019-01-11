class ShipperLanesController < ApplicationController
  before_action :set_shipper_lane, only: [:show, :edit, :update, :destroy]

  # GET /shipper_lanes
  # GET /shipper_lanes.json
  def index
    @shipper_lanes = ShipperLane.all
  end

  # GET /shipper_lanes/1
  # GET /shipper_lanes/1.json
  def show
  end

  # GET /shipper_lanes/new
  def new
    @shipper_lane = ShipperLane.new
    if params[:shipper_id].present?
      @shipper_lane.shipper_id = params[:shipper_id]
    end
  end

  # GET /shipper_lanes/1/edit
  def edit
  end

  # POST /shipper_lanes
  # POST /shipper_lanes.json
  def create
    @shipper_lane = ShipperLane.new(shipper_lane_params)
    respond_to do |format|
      if @shipper_lane.save
        format.html { redirect_to shipper_path(:id => @shipper_lane.shipper_id), notice: 'Shipper lane was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_lane }
      else
        format.html { render :new }
        format.json { render json: @shipper_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_lanes/1
  # PATCH/PUT /shipper_lanes/1.json
  def update
    respond_to do |format|
      if @shipper_lane.update(shipper_lane_params)
        format.html { redirect_to shipper_path(:id => @shipper_lane.shipper_id), notice: 'Shipper lane was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper_lane }
      else
        format.html { render :edit }
        format.json { render json: @shipper_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_lanes/1
  # DELETE /shipper_lanes/1.json
  def destroy
    @shipper_lane.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_lane.shipper_id), notice: 'Shipper lane was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_lane
      @shipper_lane = ShipperLane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_lane_params
      params[:shipper_lane][:lane_origin] = convert_array(params[:shipper_lane][:lane_origin])
      params[:shipper_lane][:lane_destination] = convert_array(params[:shipper_lane][:lane_destination])
      params[:shipper_lane][:commodities] = convert_array(params[:shipper_lane][:commodities])
      params[:shipper_lane][:preferred_load_day] = params[:shipper_lane][:preferred_load_day].to_s.tr('[]', '').tr('"', '').tr(' ', '')[1..-1].to_s
      params.require(:shipper_lane).permit(:lane_priority, :lane_origin, :lane_destination, :truck_per_week, :preferred_load_day, :notes, :shipper_id, :prefer_team, :commodities)
    end
end
