module Api
  class LocationsController < ApplicationController
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
    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:name)
      end
  end
end
