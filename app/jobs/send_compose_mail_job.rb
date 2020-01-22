class SendComposeMailJob < ApplicationJob
  queue_as :compose_mail

  def perform(contact, cc, bcc, subject, content, from, attachment_files=nil)
    contact.split(',').reject(&:blank?).map(&:to_s).each do |contact|
      if contact
        MailMailer.send_mail(contact, cc, bcc, subject, content, from, attachment_files).deliver
      end
    end
  end
end
