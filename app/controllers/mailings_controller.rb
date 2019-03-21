class MailingsController < ApplicationController
  before_action :set_listings, only: [:index]

  layout 'mail'

  def index
  end

  private

  def set_listings
    if params[:mtype].present?
      if params[:mtype] == "sent"
        @mailings = Mailing.sents(current_user.id)
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
