module Api
  class ShipperContactsController < ApplicationController
    def index
      if params[:shipper_id].present?
        @shipper_contacts = ShipperContact.where(:shipper_id => params[:shipper_id])
      else
        @shipper_contacts = []
      end
      render json: @shipper_contacts, methods: [:full_name]
    end
  end
end
