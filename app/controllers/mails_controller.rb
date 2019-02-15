class MailsController < ApplicationController
  layout 'mail'
  before_action :set_previous_controller, only: [:new]
  before_action :set_model, only: [:new]
  before_action :generate_contacts, only: [:new]
  before_action :generate_subject, only: [:new]
  before_action :generate_body, only: [:new]

  def new
    puts "#{@content}"
  end

  def create
    params[:to].each do |contact|
      MailMailer.send_mail(contact, params[:cc], params[:bcc], params[:subject], params[:content], current_user.email).deliver_now
    end
    redirect_to "/#{params[:previous_controller]}", notice: 'Mail was successfully sent.'
  end

  private
    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'mails'
      end
    end

    def set_model
      if @previous_controller == "activities"
        @activity = Activity.find(params[:id])
      elsif @previous_controller == "rates"
        @rate = Rate.find(params[:id])
      end
    end

    def generate_subject
      if @previous_controller == "activities"
        @subject = "Activity: #{generate_alphanumeric_id(@activity.campaign_name, @activity.id)} - #{@activity.campaign_name}"
      elsif @previous_controller == "rates"
        @subject = "Rate: #{@rate.mc_number} - (#{@rate.origin_city + ", " + @rate.origin_state} -> #{@rate.destination_city + ", " + @rate.destination_state})"
      end
    end

    def generate_body
      if @previous_controller == "activities"
        @content = "<div style='font-family: Poppins, sans-serif; border: 10px solid #ee9c10; width: 500px; background-color: #fff; border-radius: 25px;'>" +
                   "<div style='font-size: 50px; background-color: #ee9c10; color: #fff; padding: 1rem; text-align: center; margin-top: 0px;'><b>Activity</b></div>" +
                   "<div style='background-color:#fff; margin: 1rem; font-size: 20px; color: #707478'><b style='color: #555; padding-right: 20px;'>Campaign:</b> #{@activity.campaign_name}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Open Date:</b> #{@activity.date_stamp}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Type:</b> #{@activity.activity_type}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Contact:</b> #{@activity.carrier_contact ? @activity.carrier_contact.full_name : ''}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Steward:</b> #{@activity.user ? @activity.user.full_name : ''}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Annual Value:</b> #{@activity.annual_value}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Loads Per Week:</b> #{@activity.loads_per_week}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Status:</b> #{@activity.status ? 'Open' : 'Closed'}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Date Opened:</b> #{convert_date(@activity.date_opened)}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Date Closed:</b> #{convert_date(@activity.date_closed)}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Other Notes:</b> #{@activity.other_notes}<br/>" +
                   "</div>" +
                   "<br/><br/><div style='background-color:#fff; margin: 1rem; font-size: 20px; color: #555'>Thanks," +
                   "<br><img style='width: 50px; vertical-align: middle;' src='https://scouteye.marcelo.ph/assets/scout_fav-5a780324cf2f17ab213cf7ccbbdaa0cca037a75a40500aded47ae7eb33dda6f6.png'>" +
                   "<b style='vertical-align: middle;'>ScoutLook</b></div>" +
                   "</div>"
      elsif @previous_controller == "rates"

        @content = "<div style='font-family: Poppins, sans-serif; border: 10px solid #014b0a; width: 500px; background-color: #fff; border-radius: 25px;'>" +
                   "<div style='font-size: 50px; background-color: #014b0a; color: #fff; padding: 1rem; text-align: center; margin-top: 0px;'><b>Rate</b></div>" +
                   "<div style='background-color:#fff; margin: 1rem; font-size: 20px; color: #707478'><b style='color: #555; padding-right: 20px;'>Origin:</b> #{@rate.origin_city + ", " + @rate.origin_state}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Destination:</b> #{@rate.destination_city + ", " + @rate.destination_state}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Carrier:</b> #{@rate.carrier ? @rate.carrier.company_name : ''}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Shipper:</b> #{@rate.shipper ? @rate.shipper.company_name : ''}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Contact:</b> #{@rate.carrier_contact ? @rate.carrier_contact.full_name : (@rate.shipper_contact ? @rate.shipper_contact.full_name : '')}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Activity:</b> #{@rate.activity ? @rate.activity.campaign_name : ''}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Type:</b> #{@rate.rate_type}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Picks:</b> #{@rate.picks}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Drops:</b> #{@rate.drops}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Team:</b> #{@rate.team}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Commodities:</b> #{@rate.commodities}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Bid:</b> #{@rate.bid}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Ask:</b> #{@rate.ask}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Accepted:</b> #{@rate.accepted ? 'Yes' : 'No'}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Cost:</b> #{@rate.cost}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Currency:</b> #{@rate.money_currency}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>MC Number:</b> #{@rate.mc_number}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Notes:</b> #{@rate.notes}<br/>" +
                   "<b style='color: #555; padding-right: 20px;'>Date Created:</b> #{@rate.created_at}<br/>" +
                   "</div>" +
                   "<br/><br/><div style='background-color:#fff; margin: 1rem; font-size: 20px; color: #555'>Thanks," +
                   "<br><img style='width: 50px; vertical-align: middle;' src='https://scouteye.marcelo.ph/assets/scout_fav-5a780324cf2f17ab213cf7ccbbdaa0cca037a75a40500aded47ae7eb33dda6f6.png'>" +
                   "<b style='vertical-align: middle;'>ScoutLook</b></div>" +
                   "</div>"
      end
    end
    def generate_contacts
      begin
        if @previous_controller == "activities"
          if @activity.carrier
            @contacts = @activity.carrier.carrier_contacts.distinct(:email).pluck(:email).map(&:inspect)
          elsif @activity.shipper
            @contacts = @activity.shipper.shipper_contacts.distinct(:email).pluck(:email).map(&:inspect)
          else
            @contacts = []
          end
        elsif @previous_controller == "rates"
          if @rate.activity.carrier
            @contacts = @rate.activity.carrier.carrier_contacts.distinct(:email).pluck(:email).map(&:inspect)
          elsif @rate.activity.shipper
            @contacts = @rate.activity.shipper.shipper_contacts.distinct(:email).pluck(:email).map(&:inspect)
          else
            @contacts = []
          end
        else
          @contacts = []
        end
      rescue
        @contacts = []
      end
    end
    def mail_params
      params.permit(:to, :cc, :bcc, :subject, :content_body)
    end

end
