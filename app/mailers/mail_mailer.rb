class MailMailer < ApplicationMailer
  def send_mail(contact, cc, bcc, subject, content, from)
    @content = content
    from = (from.nil? || from.blank?) ? "no-reply@scoutlook.net" : from
      mail(
        :from => from,
        :to => contact,
        :cc => cc,
        :bcc => bcc,
        :subject => subject
      )
  end
end
