module Api
  class CarriersController < ApplicationController
    before_action :set_carrier, only: [:show, :edit, :update, :destroy]

    def show
      render json: @carrier, methods: [:default_location]
    end

    def check_mc_number
      if params[:mc_number]
        carrier = Carrier.where(:mc_number => params[:mc_number]).first
        if !carrier
          render json: {:available => true}
        else
          render json: {:error => 'MC Number already exist.', :available => false}
        end
      else
        render json: {:error => 'Please enter a Unique MC Number.', :available => false}
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_carrier
        @carrier = Carrier.find(params[:id])
      end
  end
end
