module Api
  class MailingsController < ApplicationController

    def delete_mails
      if params[:mail_ids]
        ids = params[:mail_ids].join(', ')
        Mailing.where("id IN (#{ids})").destroy_all
      end
    end

    def update_mails
      if params[:mail_ids] && params[:mtype]
        ids = params[:mail_ids].join(', ')
        @mtype = params[:mtype]
        if @mtype == 'sent'
          Mailing.where("id IN (#{ids})").update_all(sent: true, trash: false, archive: false)
        elsif @mtype == 'archive'
          Mailing.where("id IN (#{ids})").update_all(sent: false, trash: false, archive: true)
        elsif @mtype == 'trash'
          Mailing.where("id IN (#{ids})").update_all(sent: false, trash: true, archive: false)
        end
      end
    end

  end
end
