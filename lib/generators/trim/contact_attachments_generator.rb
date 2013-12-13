require 'rails/generators/active_record'

module Trim
  class ContactAttachmentsGenerator < TrimGenerator
    def create_contact_attachments
      sleep(2)
      migration_template "create_contact_attachments.rb", "db/migrate/create_contact_attachments.rb"

      say "Added contact_attachments migration to db/migrate", MESSAGE_COLOR
    end
  end
end
