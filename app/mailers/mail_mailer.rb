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

  def send_mail_blast(contact, cc, bcc, subject, content, from, current_user, attachment_files=nil)
    @content = content
    @current_user = current_user
    if attachment_files.present? && !attachment_files.nil?
      attachment_files.each do |attachment_file|
        attachments["#{attachment_file[1].original_filename}"] = File.read(attachment_file[1].tempfile)
      end
    end
    @email_template = EmailTemplate.first
    @email_links = EmailLink.order("position ASC")
    @email_link_filenames = [""]

    if !@email_template.logo_image.nil?
      if @email_template.logo_image.attached?
        @email_template_filename = "scout_logo" + @email_template.logo_image.filename.extension_with_delimiter
        if ActiveStorage::Blob.service.respond_to?(:path_for)
          attachments.inline[@email_template_filename] = File.read(ActiveStorage::Blob.service.send(:path_for, @email_template.logo_image.key))
        elsif ActiveStorage::Blob.service.respond_to?(:download)
          attachments.inline[@email_template_filename] = @email_template.logo_image.download
        end
      end
    end

    @email_links.each do |email_link|
      email_link_filename = ""
      if !email_link.logo_image.nil?
        if email_link.logo_image.attached?
          email_link_filename = email_link.name.parameterize(separator: "_") + email_link.logo_image.filename.extension_with_delimiter
          @email_link_filenames.push(email_link_filename)
          if ActiveStorage::Blob.service.respond_to?(:path_for)
            attachments.inline[email_link_filename] = File.read(ActiveStorage::Blob.service.send(:path_for, email_link.logo_image.key))
          elsif ActiveStorage::Blob.service.respond_to?(:download)
            attachments.inline[email_link_filename] = email_link.logo_image.download
          end

        end
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
