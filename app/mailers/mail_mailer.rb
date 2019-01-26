class MailMailer < ApplicationMailer
  def send_mail(contact, cc, bcc, subject, content)
    @content = content
      mail(
        :from => "no-reply@scout.net",
        :to => contact,
        :cc => cc,
        :bcc => bcc,
        :subject => subject
      )
  end
end
