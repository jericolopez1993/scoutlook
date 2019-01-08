module Api
  class CarrierContactsController < ApplicationController
    def index
      if params[:carrier_id].present?
        @carrier_contacts = CarrierContact.where(:carrier_id => params[:carrier_id])
      else
        @carrier_contacts = []
      end
      render json: @carrier_contacts, methods: [:full_name]
    end
  end
end
