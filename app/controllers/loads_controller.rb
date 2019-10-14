class LoadsController < ApplicationController
  before_action :set_load, only: [:show]


  # GET /loads
  # GET /loads.json
  def index
    # @loads = DfLoad.all.limit(50)
    respond_to do |format|
      format.html
      format.json { render json: DfLoadDatatable.new(params) }
    end
  end

  # GET /load/1
  # GET /load/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load
      @load = DfLoad.where('"Load_Num" = ?', params[:id]).first
    end
end
