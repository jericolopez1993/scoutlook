class SendComposeMailJob < ApplicationJob
  queue_as :compose_mail

  def perform(contact, cc, bcc, subject, content, from, attachment_files=nil)
    # contact.split(',').map(&:to_s).each do |contact|
    #   if !contact.strip.empty?
    #     MailMailer.send_mail(contact, cc, bcc, subject, content, from, attachment_files).deliver
    #   end
    # end
  end
end
