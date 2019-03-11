class TileTabsController < ApplicationController
  before_action :set_tile_tab, only: [:show, :edit, :update, :destroy, :index]

  # GET /tile_tabs
  # GET /tile_tabs.json
  def index
    start_date = organize_date(cookies[:start_date])
    end_date = organize_date(cookies[:end_date])
    if params[:navigation_type] == "previous"
      cookies[:start_date] = {:value => Date.parse(start_date) - 8.day, :expires => 1.day.from_now}
      cookies[:end_date] = {:value => Date.parse(start_date) - 1.day, :expires => 1.day.from_now}
    elsif params[:navigation_type] == "current"
      cookies[:start_date] = {:value => Date.today() - 1, :expires => 1.day.from_now}
      cookies[:end_date] = {:value => Date.today() + 6, :expires => 1.day.from_now}
    elsif params[:navigation_type] == "next"
      cookies[:start_date] = {:value => Date.parse(end_date) + 1.day, :expires => 1.day.from_now}
      cookies[:end_date] = {:value => Date.parse(end_date) + 8.day, :expires => 1.day.from_now}
    else
      cookies[:start_date] = {:value => Date.today() - 1, :expires => 1.day.from_now}
      cookies[:end_date] = {:value => Date.today() + 6, :expires => 1.day.from_now}
    end
    render "load_tiles/index"
  end

  # GET /tile_tabs/1
  # GET /tile_tabs/1.json
  def show
    cookies[:start_date] = {:value => Date.today() - 1, :expires => 1.day.from_now}
    cookies[:end_date] = {:value => Date.today() + 6, :expires => 1.day.from_now}
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
    cookies[:start_date] = {:value => Date.today() - 1, :expires => 1.day.from_now}
    cookies[:end_date] = {:value => Date.today() + 6, :expires => 1.day.from_now}

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
    cookies[:start_date] = {:value => Date.today() - 1, :expires => 1.day.from_now}
    cookies[:end_date] = {:value => Date.today() + 6, :expires => 1.day.from_now}
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
