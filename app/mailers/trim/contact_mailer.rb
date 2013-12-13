module Trim
  class ContactMailer < TrimMailer
    # This is the message sent to the sender.
    def confirm_email(contact)
      # Don't send email to nobody.
      unless contact.email.blank?
        user_defined_mail contact.email, :user_contact_message_confirmation_email, :record => contact
      end
    end

    # This is the message sent to us.
    def contact_email(contact)
      @contact = contact

      if Trim.allow_attachments_for_contact_messages
        @contact.attachments.each do |file|
          attachments[file.attachment_file_name] = read_attachment(file)
        end
      end

      # Don't send email to nobody.
      unless @contact.contact_subject.email.blank? 
        mail( :to => @contact.contact_subject.email, 
              :subject => "A Message from the Website")
      end
    end

    def read_attachment(file)
      open(file.attachment.url).read
    end
  end
end
