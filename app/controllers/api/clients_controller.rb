module Api
  class ClientsController < ApplicationController
    before_action :set_client, only: [:show, :edit, :update, :destroy]

    def show
      render json: @client, methods: [:default_location]
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_client
        @client = Client.find(params[:id])
      end
  end
end
