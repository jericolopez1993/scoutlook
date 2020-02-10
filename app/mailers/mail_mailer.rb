class MailMailer < ApplicationMailer
  def send_mail(contact, cc, bcc, subject, content, from, attachment_files=nil)
    @content = content
    if attachment_files.present? && !attachment_files.nil?
        attachment_files.each do |attachment_file|
          attachments["#{attachment_file[1].original_filename}"] = File.read(attachment_file[1].tempfile)
        end
      end
    from = (from.nil? || from.blank?) ? "no-reply@scoutlook.net" : from
    mail(
      :from => from,
      :to => contact,
      :subject => subject
    )
  end
end
