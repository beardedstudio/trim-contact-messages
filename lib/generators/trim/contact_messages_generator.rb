require 'rails/generators/active_record'

module Trim
  # This generator adds a migration for the User model
  class ContactMessagesGenerator < TrimGenerator

    include Rails::Generators::Migration
    source_root File.expand_path('../../templates', __FILE__)

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def create_contact_messages
      sleep(2)
      migration_template "create_contact_messages.rb", "db/migrate/create_contact_messages.rb"

      say "Added contact_messages migration to db/migrate", MESSAGE_COLOR
    end

    def create_contact_subjects
      sleep(2)
      migration_template "create_contact_subjects.rb", "db/migrate/create_contact_subjects.rb"

      say "Added contact_subjects migration to db/migrate", MESSAGE_COLOR
    end

    def create_contact_attachments
      sleep(2)
      migration_template "create_contact_attachments.rb", "db/migrate/create_contact_attachments.rb"

      say "Added contact_attachments migration to db/migrate", MESSAGE_COLOR
    end

    def create_rakismet_config
      sleep(2)
      create_file 'config/initializers/rakismet.rb'
      out = <<-out
# if you don't have an akismet key, get one at https://akismet.com/signup

#{Rails.application.class}.config.rakismet.key = 'your akismet key'
#{Rails.application.class}.config.rakismet.url = 'http://yourdomain.com'
      out

      append_to_file 'config/initializers/rakismet.rb', out
    end

    def add_route_for_contact_messages
      route("resources :contact_messages, :only => :create")
      say "Added contact_messages routes to config/routes.rb", MESSAGE_COLOR
    end

    def migrate
      say 'Running rake db:migrate', MESSAGE_COLOR

      unless system 'rake db:migrate'
        say "There was an error finalizing the install. 'rake db:migrate' failed", ERROR_COLOR
      end
    end

  end
end
