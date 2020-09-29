class SendComposeMailBlastJob < ApplicationJob
  queue_as :compose_mail_blast

  def perform(contact, cc, bcc, subject, content, from, mail_id, current_user, attachment_files=nil)
    @mail = Mailing.find(mail_id)
    @mail.update_attributes(status: "Sending")
    begin
      contact.split(',').reject(&:blank?).map(&:to_s).each do |contact|
        if contact
          MailMailer.send_mail_blast(contact.downcase.gsub(/[[:space:]]/, ''), cc, bcc, subject, content, from, current_user, attachment_files).deliver
        end
      end
      @mail.update_attributes(status: "Delivered", date_sent: Time.now)
    rescue
      @mail.update_attributes(status: "Failed")
    end
  end
end
