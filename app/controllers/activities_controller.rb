class ActivitiesController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    else
      @shipper_activities = []
      @carrier_activities = []
      if current_user.has_role?(:admin)
        @shipper_activities = ShipperActivity.all
        @carrier_activities = CarrierActivity.all
        authorize @shipper_activities
        authorize @carrier_activities
      elsif current_user.has_role?(:steward) || current_user.ro || current_user.cs
        @shipper_activities = ShipperActivity.where(:user_id => current_user.id)
        @carrier_activities = CarrierActivity.where(:user_id => current_user.id)
        authorize @shipper_activities
        authorize @carrier_activities
      end
    end
  end
end
