module Api
  class ActivitiesController < ApplicationController
    def index
      if params[:carrier_id].present?
        @activities = Activity.where(:carrier_id => params[:carrier_id])
      elsif params[:shipper_id].present?
        @activities = Activity.where(:shipper_id => params[:shipper_id])
      else
        @activities = []
      end
      render json: @activities
    end
  end
end
