class MessagesController < ApplicationController
  before_action :set_listings, only: [:index]

  layout 'mail'

  def index
  end

  def show
    @message = Message.find(params[:id])
    @mtype = params[:mtype]
  end

  def resend
    @message = Message.find(params[:id])
    SendSmsJob.perform_later(@message.recipient, @message.content_body)
    sms = Message.new
    sms.recipient = @message.recipient
    sms.content_body = @message.content_body
    sms.user_id = current_user.id
    sms.sent = true
    sms.save
    redirect_to message_path(:id => @message.id, :mtype => params[:mtype])
  end

  private

  def set_listings
    if params[:mtype].present?
      if params[:mtype] == "sent"
        @messages = Message.sents
      elsif params[:mtype] == "trash"
        @messages = Message.trashes
      elsif params[:mtype] == "archive"
        @messages = Message.archives
      else
        params[:mtype] = "inbox"
        @messages = Message.inboxes
      end
    else
      params[:mtype] = "inbox"
      @messages = Message.inboxes
    end
    @mtype = params[:mtype]
  end

end
