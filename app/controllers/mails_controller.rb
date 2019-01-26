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
      MailMailer.send_mail(contact, params[:cc], params[:bcc], params[:subject], params[:content]).deliver_now
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
        @subject = "Activity: #{@rate.mc_number} - (#{@rate.origin_city + ", " + @rate.origin_state} -> #{@rate.destination_city + ", " + @rate.destination_state})"
      end
    end

    def generate_body
      if @previous_controller == "activities"
        @content = "<p>Hi, <br/><br/> <b>Here are details about an Activity</b></p>" +
                   "<p>Campaign: #{@activity.campaign_name}<br/>" +
                   "Open Date: #{@activity.date_stamp}<br/>" +
                   "Type: #{@activity.activity_type}<br/>" +
                   "Contact: #{@activity.carrier_contact ? @activity.carrier_contact.full_name : ''}<br/>" +
                   "Steward: #{@activity.user ? @activity.user.full_name : ''}<br/>" +
                   "Annual Value: #{@activity.annual_value}<br/>" +
                   "Loads Per Week: #{@activity.loads_per_week}<br/>" +
                   "Status: #{@activity.status ? 'Open' : 'Closed'}<br/>" +
                   "Date Opened: #{convert_date(@activity.date_opened)}<br/>" +
                   "Date Closed: #{convert_date(@activity.date_closed)}<br/>" +
                   "Other Notes: #{@activity.other_notes}<br/>" +
                   "</p>" +
                   "<br/><br/><p>Thanks, <br/>Scout Logistics</p>"
      elsif @previous_controller == "rates"
        @content = "<p>Hi, <br/><br/> <b>Here are details about an Rate</b></p>" +
                   "<p>Origin: #{@rate.origin_city + ", " + @rate.origin_state}<br/>" +
                   "Destination: #{@rate.destination_city + ", " + @rate.destination_state}<br/>" +
                   "Carrier: #{@rate.carrier ? @rate.carrier.company_name : ''}<br/>" +
                   "Shipper: #{@rate.shipper ? @rate.shipper.company_name : ''}<br/>" +
                   "Contact: #{@rate.carrier_contact ? @rate.carrier_contact.full_name : (@rate.shipper_contact ? @rate.shipper_contact.full_name : '')}<br/>" +
                   "Activity: #{@rate.activity ? @rate.activity.campaign_name : ''}<br/>" +
                   "Type: #{@rate.rate_type}<br/>" +
                   "Picks: #{@rate.picks}<br/>" +
                   "Drops: #{@rate.drops}<br/>" +
                   "Team: #{@rate.team}<br/>" +
                   "Commodities: #{@rate.commodities}<br/>" +
                   "Bid: #{@rate.bid}<br/>" +
                   "Ask: #{@rate.ask}<br/>" +
                   "Accepted: #{@rate.accepted ? 'Yes' : 'No'}<br/>" +
                   "Cost: #{@rate.cost}<br/>" +
                   "Currency: #{@rate.money_currency}<br/>" +
                   "MC Number: #{@rate.mc_number}<br/>" +
                   "Notes: #{@rate.notes}<br/>" +
                   "Date Created: #{@rate.created_at}<br/>" +
                   "</p>" +
                   "<br/><br/><p>Thanks, <br/>Scout Logistics</p>"
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
