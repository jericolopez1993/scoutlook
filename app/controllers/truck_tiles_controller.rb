class TruckTilesController < ApplicationController
  before_action :set_truck_tile, only: [:show, :edit, :update, :destroy]
  before_action :set_tile_tab, only: [:show, :edit, :update, :destroy, :create]

  # GET /truck_tiles
  # GET /truck_tiles.json
  def index
    @truck_tiles = TruckTile.all
  end

  # GET /truck_tiles/1
  # GET /truck_tiles/1.json
  def show
    respond_to do |format|
      format.js { }
    end
  end

  # GET /truck_tiles/new
  def new
    @truck_tile = TruckTile.new
  end

  # GET /truck_tiles/1/edit
  def edit
    respond_to do |format|
      format.js { }
    end
  end

  # POST /truck_tiles
  # POST /truck_tiles.json
  def create
    @truck_tile = TruckTile.new(truck_tile_params)

    respond_to do |format|
      @truck_tile.save
      format.js { }
    end
  end

  # PATCH/PUT /truck_tiles/1
  # PATCH/PUT /truck_tiles/1.json
  def update
    if @truck_tile.load_tile
      @truck_tile.load_tile.update_attributes(:status => params[:truck_tile][:status])
    end
    respond_to do |format|
        @truck_tile.update(truck_tile_params)
      # if params[:truck_tile][:load_tile_id].present?
      #   if @truck_tile.load_tile
      #     if @truck_tile.load_tile.id != params[:truck_tile][:load_tile_id]
      #       @truck_tile.load_tile.update_attributes(:truck_tile_id => nil)
      #     end
      #   end
      #   LoadTile.find(params[:truck_tile][:load_tile_id]).update_attributes(:truck_tile_id => @truck_tile.id)
      # else
      #   @truck_tile.load_tile && @truck_tile.load_tile.update_attributes(:truck_tile_id => nil)
      # end
      format.js { }
    end
  end
  # DELETE /truck_tiles/1.json
  def destroy
    @truck_tile.destroy
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truck_tile
      @truck_tile = TruckTile.find(params[:id])
    end

    def set_tile_tab
      if action_name == "create"
        @tile_tab = TileTab.find(params[:truck_tile][:tile_tab_id])
      else
        @tile_tab = @truck_tile.tile_tab
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truck_tile_params
      params[:truck_tile][:origin] = convert_array(params[:truck_tile][:origin])
      params[:truck_tile][:destination] = convert_array(params[:truck_tile][:destination])
      if params[:truck_tile][:load_date].present?
        load_date = params[:truck_tile][:load_date].split("/")
        params[:truck_tile][:load_date] = load_date[2] + "-" + load_date[0] + "-" + load_date[1]
      end
      if params[:truck_tile][:del_date].present?
        del_date = params[:truck_tile][:del_date].split("/")
        params[:truck_tile][:del_date] = del_date[2] + "-" + del_date[0] + "-" + del_date[1]
      end
      if !params[:truck_tile][:status].present?
        params[:truck_tile][:status] = "Open"
      end
      params.require(:truck_tile).permit(:name, :load_date, :priority, :status, :origin, :destination, :details, :carrier_id, :shipper_id, :dispatcher_id, :bill_rate, :pu_time, :pu_general_time, :del_date, :del_time, :del_general_time, :teams, :tile_tab_id)
    end
end
