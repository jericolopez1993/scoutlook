module Api
  class TruckTilesController < ApplicationController
    before_action :set_truck_tile, only: [:show, :edit, :update, :destroy]
    before_action :set_tile_tab, only: [:show, :edit, :update, :destroy, :create]
    before_action :set_load_date, only: [:index, :update]

    def index
      if params[:load_date].present? && params[:tile_tab_id].present?

        @truck_tiles = TruckTile.where(:load_date => params[:load_date], :tile_tab_id => params[:tile_tab_id])
      else
        @truck_tiles = []
      end
      render json: @truck_tiles, methods: [:location_with_uniq_id]
    end

    def show
      render json: @truck_tile
    end

    def update
      if params[:load_date].present? && !params[:load_date].nil?
        if @truck_tile.update_attributes(:load_date => params[:load_date])
          render 'load_tiles/tiles', :layout => false
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

      def set_tile_tab
        if action_name == "create"
          @tile_tab = TileTab.find(params[:truck_tile][:tile_tab_id])
        else
          @tile_tab = @truck_tile.tile_tab
        end
      end

      def set_load_date
        if params[:load_date]
          load_date = params[:load_date].split("/")
          params[:load_date] = load_date[2] + "-" + load_date[0] + "-" + load_date[1]
        end
      end
  end
end
