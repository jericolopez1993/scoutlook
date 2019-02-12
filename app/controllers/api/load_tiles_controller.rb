module Api
  class LoadTilesController < ApplicationController
    before_action :set_load_tile, only: [:show, :edit, :update, :destroy]

    def show
      render json: @load_tile
    end

    def update
      if params[:load_date].present? && !params[:load_date].nil?
        if @load_tile.update_attributes(:load_date => params[:load_date])
          head :no_content
        else
          render json: { status: 'failed' }, status: :unprocessable_entity
        end
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_load_tile
        @load_tile = LoadTile.find(params[:id])
      end
  end
end
