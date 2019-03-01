class TileTabsController < ApplicationController
  before_action :set_tile_tab, only: [:show, :edit, :update, :destroy]

  # GET /tile_tabs
  # GET /tile_tabs.json
  def index
    @tile_tabs = TileTab.all
  end

  # GET /tile_tabs/1
  # GET /tile_tabs/1.json
  def show
    render "load_tiles/index"
  end

  # GET /tile_tabs/new
  def new
    @tile_tab = TileTab.new
  end

  # GET /tile_tabs/1/edit
  def edit
    respond_to do |format|
      format.js { }
    end
  end

  # POST /tile_tabs
  # POST /tile_tabs.json
  def create
    @tile_tab = TileTab.new(tile_tab_params)

    respond_to do |format|
      @tile_tab.save
      format.js { }
    end
  end

  # PATCH/PUT /tile_tabs/1
  # PATCH/PUT /tile_tabs/1.json
  def update
    respond_to do |format|
      @tile_tab.update(tile_tab_params)
      format.js { }
    end
  end

  # DELETE /tile_tabs/1
  # DELETE /tile_tabs/1.json
  def destroy
    @tile_tab.destroy
    @tile_tab = TileTab.first
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tile_tab
      @tile_tab = TileTab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tile_tab_params
      params.require(:tile_tab).permit(:name, :notes, :created_by)
    end
end
