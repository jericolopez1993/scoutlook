module Api
  class TruckTilesController < ApplicationController
    before_action :set_truck_tile, only: [:show, :edit, :update, :destroy]

    def show
      render json: @truck_tile
    end

    def update
      if params[:load_date].present? && !params[:load_date].nil?
        if @truck_tile.update_attributes(:load_date => params[:load_date])
          head :no_content
        else
          render json: { status: 'failed' }, status: :unprocessable_entity
        end
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_truck_tile
        @truck_tile = TruckTile.find(params[:id])
      end
  end
end
