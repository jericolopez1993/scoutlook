module Api
  class MailingsController < ApplicationController

    def delete_mails
      if params[:mail_ids]
        ids = params[:mail_ids].join(', ')
        Mailing.where("id IN (#{ids})").destroy_all
      end

      if params[:mail_id]
        Mailing.find(params[:mail_id]).destroy
      end
    end

    def update_mails
      if params[:mtype]
        @mtype = params[:mtype]
        if params[:mail_ids]
          ids = params[:mail_ids].join(', ')
          if @mtype == 'sent'
            Mailing.where("id IN (#{ids})").update_all(sent: true, trash: false, archive: false)
          elsif @mtype == 'archive'
            Mailing.where("id IN (#{ids})").update_all(sent: false, trash: false, archive: true)
          elsif @mtype == 'trash'
            Mailing.where("id IN (#{ids})").update_all(sent: false, trash: true, archive: false)
          end
        end

        if params[:mail_id]
          if @mtype == 'sent'
            Mailing.find(params[:mail_id]).update_attributes(sent: true, trash: false, archive: false)
          elsif @mtype == 'archive'
            Mailing.find(params[:mail_id]).update_attributes(sent: false, trash: false, archive: true)
          elsif @mtype == 'trash'
            Mailing.find(params[:mail_id]).update_attributes(sent: false, trash: true, archive: false)
          end
        end
      end
    end

  end
end
