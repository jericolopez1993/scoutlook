class MailingsController < ApplicationController
  # before_action :set_listings, only: [:index]

  layout 'mail'

  def index
    @mailings = Mailing.all
  end

  def pending
    @mailings = Mailing.pending
  end

  def sending
    @mailings = Mailing.sending
  end

  def delivered
    @mailings = Mailing.delivered
  end

  def failed
    @mailings = Mailing.failed
  end

  def show
    @mailing = Mailing.find(params[:id])
    @mtype = params[:mtype]
  end

  def resend
    @mailing = Mailing.find(params[:id])
    attachment_files = @mailing.attachment_files.attached? ? @mailing.attachment_files : nil
    mail = Mailing.new
    mail.recipient = @mailing.recipient
    mail.sender = @mailing.sender
    mail.subject = @mailing.subject
    mail.content_body = @mailing.content_body
    mail.user_id = @mailing.user_id
    mail.sent = true
    if mail.save
      unless @mailing.attachment_files.nil?
        if @mailing.attachment_files.attached?
          mail.attachment_files.attach(@mailing.attachment_files)
        end
      end
    end
    SendComposeMailJob.delay.perform_now(@mailing.recipient, nil, nil, @mailing.subject, @mailing.content_body, current_user.email, mail.id, attachment_files)
    redirect_to mailing_path(:id => @mailing.id, :mtype => params[:mtype])
  end

  private

  def set_listings
    if params[:mtype].present?
      if params[:mtype] == "sent"
        if current_user.email == "admin@test.com"
          @mailings = Mailing.all_sents
        else
          @mailings = Mailing.sents(current_user.id)
        end

      elsif params[:mtype] == "trash"
        @mailings = Mailing.trashes(current_user.id)
      elsif params[:mtype] == "archive"
        @mailings = Mailing.archives(current_user.id)
      else
        params[:mtype] = "inbox"
        @mailings = Mailing.inboxes(current_user.id)
      end
    else
      params[:mtype] = "inbox"
      @mailings = Mailing.inboxes(current_user.id)
    end
    @mtype = params[:mtype]
  end

end
