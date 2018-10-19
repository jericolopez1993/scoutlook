module Api
  class LocationsController < ApplicationController
  include HTTParty
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
      @origin = ""
      @destination = ""

      if params[:origin].present?
        origin = Location.find(params[:origin])
        @origin = origin.address + " " + origin.state + "," + origin.country
      end

      if params[:destination].present?
        destination = Location.find(params[:destination])
        @destination = destination.address + " " +destination.state + "," + destination.country
      end
      str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
      response = HTTParty.get(str_url)
      body = JSON.parse(response.body)
      distance = body['rows'][0]['elements'][0]['distance']['value']
      static_map_url = "https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\&markers=size:mid%7Ccolor:red%7C#{@origin}%7C#{@destination}&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
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
