class SendComposeMailJob < ApplicationJob
  queue_as :compose_mail

  def perform(contact, cc, bcc, subject, content, from, mail_id attachment_files=nil)
    @mail = Mailing.find(mail_id)
    @mail.update_attributes(status: "Sending")
    begin
      contact.split(',').reject(&:blank?).map(&:to_s).each do |contact|
        if contact
          MailMailer.send_mail(contact, cc, bcc, subject, content, from, attachment_files).deliver
        end
      end
      @mail.update_attributes(status: "Delivered", date_sent: Time.now)
    rescue
      @mail.update_attributes(status: "Failed")
    end
  end
end
