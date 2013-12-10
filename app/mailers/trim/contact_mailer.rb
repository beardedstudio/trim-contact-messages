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
      # Add attachments if they are present
      @contact.attachments.each do |file|
        attachments[file.attachment_file_name] = open(file.attachment.url).read
      end
      # Don't send email to nobody.
      unless @contact.contact_subject.email.blank? 
        mail( :to => @contact.contact_subject.email, 
              :subject => "A Message from the Website")
      end
    end
  end
end
