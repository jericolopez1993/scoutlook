module Api
  class CarriersController < ApplicationController
    before_action :set_carrier, only: [:show, :edit, :update, :destroy]

    def show
      render json: @carrier, methods: [:default_location]
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_carrier
        @carrier = Carrier.find(params[:id])
      end
  end
end
