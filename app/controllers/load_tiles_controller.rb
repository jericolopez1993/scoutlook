class LoadTilesController < ApplicationController
  before_action :set_load_tile, only: [:show, :edit, :update, :destroy]
  before_action :set_tile_tab, only: [:show, :edit, :update, :destroy, :create]


  # GET /load_tiles
  # GET /load_tiles.json
  def index
    @tile_tab = TileTab.first
  end

  # GET /load_tiles/1
  # GET /load_tiles/1.json
  def show
    respond_to do |format|
      format.js { }
    end
  end

  # GET /load_tiles/new
  def new
    @load_tile = LoadTile.new
  end

  # GET /load_tiles/1/edit
  def edit
    respond_to do |format|
      format.js { }
    end
  end

  # POST /load_tiles
  # POST /load_tiles.json
  def create
    if params[:load_tile][:truck_tile_id].present?
      status = 'Covered'
      if ['Covered', 'Dispatched'].include?(params[:load_tile][:status])
        status = params[:load_tile][:status]
      end
      TruckTile.find(params[:load_tile][:truck_tile_id]).update_attributes(:status => status)
      params[:load_tile][:status] = status
    end
    @load_tile = LoadTile.new(load_tile_params)

    respond_to do |format|
      @load_tile.save
      format.js { }
    end
  end

  # PATCH/PUT /load_tiles/1
  # PATCH/PUT /load_tiles/1.json
  def update
    if params[:load_tile][:truck_tile_id].present?
      if @load_tile.truck_tile && @load_tile.truck_tile_id != params[:load_tile][:truck_tile_id]
        @load_tile.truck_tile.update_attributes(:status => 'Open')
      end
      status = 'Covered'
      if ['Covered', 'Dispatched'].include?(params[:load_tile][:status])
        status = params[:load_tile][:status]
      end
      TruckTile.find(params[:load_tile][:truck_tile_id]).update_attributes(:status => status)
      params[:load_tile][:status] = status
    else
      if @load_tile.truck_tile
        @load_tile.truck_tile.update_attributes(:status => status)
      end
    end
    respond_to do |format|
      @load_tile.update(load_tile_params)
      format.js { }
    end
  end

  # DELETE /load_tiles/1
  # DELETE /load_tiles/1.json
  def destroy
    @load_tile.destroy
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load_tile
      @load_tile = LoadTile.find(params[:id])
    end

    def set_tile_tab
      if action_name == "create"
        @tile_tab = TileTab.find(params[:load_tile][:tile_tab_id])
      else
        @tile_tab = @load_tile.tile_tab
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_tile_params
      params[:load_tile][:origin] = convert_array(params[:load_tile][:origin])
      params[:load_tile][:destination] = convert_array(params[:load_tile][:destination])
      if params[:load_tile][:load_date].present?
        load_date = params[:load_tile][:load_date].split("/")
        params[:load_tile][:load_date] = load_date[2] + "-" + load_date[1] + "-" + load_date[0]
      end
      if params[:load_tile][:del_date].present?
        del_date = params[:load_tile][:del_date].split("/")
        params[:load_tile][:del_date] = del_date[2] + "-" + del_date[1] + "-" + del_date[0]
      end
      params.require(:load_tile).permit(:name, :load_date, :priority, :status, :origin, :destination, :details, :carrier_id, :shipper_id, :salesperson_id, :bill_rate, :origin_city, :destination_city, :picks, :drops, :pu_time, :pu_general_time, :del_date, :del_time, :del_general_time, :teams, :truck_tile_id, :tile_tab_id)
    end
end
