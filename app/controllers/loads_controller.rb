class LoadsController < ApplicationController
  before_action :set_load, only: [:show, :details]


  # GET /loads
  # GET /loads.json
  def index
    # @loads = DfLoad.listings.limit(50)
    respond_to do |format|
      format.html
      format.json { render json: DfLoadDatatable.new(params, view_context: view_context) }
    end
  end

  # GET /load/1
  # GET /load/1.json
  def show
  end


  def details
    respond_to do |format|
      format.js { }
    end
  end

  def tiles
    session[:start_date] = Date.today() - 30
    session[:end_date] = Date.today() + 1
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load
      @load = DfLoad.listings.where('load_num = ?', params[:id]).first
    end
end
