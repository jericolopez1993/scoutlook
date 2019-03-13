module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def update
      if params[:carrier_categories].present? && !params[:carrier_categories].blank?
        current_user.update_attributes(:carrier_categories => params[:carrier_categories])
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_user
        @user = User.find(params[:id])
      end
  end
end
