module Api
  class MessagesController < ApplicationController
    before_action :authenticate_user!, :except => [:receive]

    def delete_messages
      if params[:sms_ids]
        ids = params[:sms_ids].join(', ')
        Message.where("id IN (#{ids})").destroy_all
      end

      if params[:sms_id]
        Message.find(params[:sms_id]).destroy
      end
    end

    def update_messages
      if params[:mtype]
        @mtype = params[:mtype]
        if params[:sms_ids]
          ids = params[:sms_ids].join(', ')
          if @mtype == 'sent'
            Message.where("id IN (#{ids})").update_all(sent: true, trash: false, archive: false)
          elsif @mtype == 'archive'
            Message.where("id IN (#{ids})").update_all(sent: false, trash: false, archive: true)
          elsif @mtype == 'trash'
            Message.where("id IN (#{ids})").update_all(sent: false, trash: true, archive: false)
          end
        end

        if params[:sms_id]
          if @mtype == 'sent'
            Message.find(params[:sms_id]).update_attributes(sent: true, trash: false, archive: false)
          elsif @mtype == 'archive'
            Message.find(params[:sms_id]).update_attributes(sent: false, trash: false, archive: true)
          elsif @mtype == 'trash'
            Message.find(params[:sms_id]).update_attributes(sent: false, trash: true, archive: false)
          end
        end
      end
    end

    def receive
      if params['from'] && params['body']
        sms = Message.new
        sms.recipient = params['from']
        sms.content_body = params['body']
        sms.inbox = true
        if sms.save
          render :json => {}, :status => :ok
        else
          render :json => {status: 'failed'}, :status => :unprocessable_entity
        end
      else
          render :json => {status: 'failed'}, :status => :unprocessable_entity
      end
    end

  end
end
