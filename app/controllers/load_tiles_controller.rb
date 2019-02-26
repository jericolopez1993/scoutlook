class LoadTilesController < ApplicationController
  before_action :set_load_tile, only: [:show, :edit, :update, :destroy]

  # GET /load_tiles
  # GET /load_tiles.json
  def index
    @load_tiles = LoadTile.all
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
    @load_tile = LoadTile.new(load_tile_params)

    respond_to do |format|
      @load_tile.save
      format.js { }
    end
  end

  # PATCH/PUT /load_tiles/1
  # PATCH/PUT /load_tiles/1.json
  def update
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_tile_params
      params[:load_tile][:origin] = convert_array(params[:load_tile][:origin])
      params[:load_tile][:destination] = convert_array(params[:load_tile][:destination])
      if params[:load_tile][:load_date].present?
        params[:load_tile][:load_date] = Date::strptime(params[:load_tile][:load_date], "%m/%d/%Y")
      else
        params[:load_tile][:load_date] = nil
      end
      params.require(:load_tile).permit(:name, :load_date, :priority, :status, :origin, :destination, :details, :carrier_id, :shipper_id, :salesperson_id, :bill_rate, :origin_city, :destination_city, :picks, :drops, :pu_time, :pu_general_time, :del_date, :del_time, :del_general_time, :teams, :truck_tile_id)
    end
end
