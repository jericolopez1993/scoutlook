module Api
  class LocationsController < ApplicationController
    include HTTParty
    include ApplicationHelper
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    require 'uri'

    def create
      @location = Location.new(location_params)
      if Location.where(:name => @location.name).length > 0
        render json: nil
      else
        if @location.save
          render json: @location
        else
          render json: nil
        end
      end
    end

    def show
      render json: @location
    end

    def distance
      distance = get_distance(params[:origin], params[:destination])
      static_map_url = get_map(params[:origin], params[:destination])
      render json: {:distance => distance, :img_url => static_map_url}
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:name)
      end

      def set_location
        @location = Location.find(params[:id])
      end

  end
end
