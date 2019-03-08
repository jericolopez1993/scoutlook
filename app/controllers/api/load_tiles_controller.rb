module Api
  class LoadTilesController < ApplicationController
    before_action :set_load_tile, only: [:show, :edit, :update, :destroy]
    before_action :set_tile_tab, only: [:show, :edit, :update, :destroy, :create]

    def show
      render json: @load_tile
    end

    def update
      if params[:load_date].present? && !params[:load_date].nil?
        load_date = params[:load_date].split("/")
        params[:load_date] = load_date[2] + "-" + load_date[0] + "-" + load_date[1]
        if @load_tile.update_attributes(:load_date => params[:load_date])
          render 'load_tiles/tiles', :layout => false
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
      def set_tile_tab
        if action_name == "create"
          @tile_tab = TileTab.find(params[:load_tile][:tile_tab_id])
        else
          @tile_tab = @load_tile.tile_tab
        end
      end
  end
end
