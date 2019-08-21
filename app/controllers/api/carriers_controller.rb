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

    def summaries
      reefers = 0
      teams = 0
      last_month = 0
      last_6_months = 0
      if params[:ids] && !params[:ids].blank?
        carriers = Carrier.where("carriers.id IN (#{params[:ids]})")
        latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers WHERE carriers.id IN (#{params[:ids]}))")
        reefers = (carriers.sum("carriers.reefers")).round
        teams = (carriers.sum("carriers.teams")).round
        last_month = (latest_date.sum("loadsh_num")).round
        last_6_months = (latest_date.sum("loadsh_num_6mon")).round
      else
        carriers = Carrier.all
        latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers)")
        reefers = (carriers.sum("carriers.reefers")).round
        teams = (carriers.sum("carriers.teams")).round
        last_month = (latest_date.sum("loadsh_num")).round
        last_6_months = (latest_date.sum("loadsh_num_6mon")).round
      end
      render json: {reefers: reefers, teams: teams, last_month: last_month, last_6_months: last_6_months}
    end

    def my_summaries
      reefers = 0
      teams = 0
      last_month = 0
      last_6_months = 0
      if params[:ids] && !params[:ids].blank?
        carriers = Carrier.where("carriers.id IN (#{params[:ids]})")
        latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers WHERE carriers.id IN (#{params[:ids]}))")
        reefers = (carriers.sum("carriers.reefers")).round
        teams = (carriers.sum("carriers.teams")).round
        last_month = (latest_date.sum("loadsh_num")).round
        last_6_months = (latest_date.sum("loadsh_num_6mon")).round
      else
        carriers = Carrier.mine(current_user.id)
        latest_date = McLatestDate.where("mcnum IN (SELECT mc_number FROM carriers WHERE relationship_owner = #{current_user.id})")
        reefers = (carriers.sum("carriers.reefers")).round
        teams = (carriers.sum("carriers.teams")).round
        last_month = (latest_date.sum("loadsh_num")).round
        last_6_months = (latest_date.sum("loadsh_num_6mon")).round
      end
      render json: {reefers: reefers, teams: teams, last_month: last_month, last_6_months: last_6_months}
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def set_carrier
        @carrier = Carrier.find(params[:id])
      end
  end
end
