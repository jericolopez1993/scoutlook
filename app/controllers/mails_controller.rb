class MailsController < ApplicationController
  layout 'mail'
  before_action :set_previous_controller, only: [:new]

  def new
    begin
      if @previous_controller == "activities"
        @contacts = Activity.find(params[:id]).carrier.carrier_contacts.distinct(:email).pluck(:email).map(&:inspect)
      elsif @previous_controller == "rates"
        @contacts = Rate.find(params[:id]).activity.carrier.carrier_contacts.distinct(:email).pluck(:email).map(&:inspect)
      else
        @contacts = []
      end
    rescue
      @contacts = []
    end
    puts "#{@contacts}"
  end

  def create
  end

  private
  def set_previous_controller
    if params[:previous_controller].present?
      @previous_controller = params[:previous_controller]
    else
      @previous_controller = 'mails'
    end
  end
    def mail_params
      params.permit(:to, :cc, :bcc, :subject, :content_body)
    end

end
