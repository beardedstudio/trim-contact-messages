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

    def add_route_for_contact_messages
      route("resources :contact_messages, :only => :create")
      say "Added contact_messages routes to config/routes.rb", MESSAGE_COLOR
    end

    def create_rakismet_config
      sleep(2)
      create_file 'config/initializers/rakismet.rb'
      out = <<-out
# if you don't have an akismet key, get one at https://akismet.com/signup
if defined?(#{Rails.application.class}.config.rakismet)
  #{Rails.application.class}.config.rakismet.key = ENV['RAKISMET_KEY']
  #{Rails.application.class}.config.rakismet.url = ENV['RAKISMET_URL']
end
      out

      append_to_file 'config/initializers/rakismet.rb', out
    end

    def update_trim_config
      out = <<-out


  ####
  #
  #  Contact Messages
  #
  ####

  ## Use akismet for spam prevention

  ## Akismet api key and url can be set at
  ## ENV['RAKISMET_KEY'] and ENV['RAKISMET_URL'] respectively,
  ## or modified directly in config/initializers/rakismet.rb

  # config.use_akismet = false


  ## Allow attachments for contact_messages

  ## To enable attachments, you must set this value to true,
  ## then run rails generate trim:contact_attachments to create a migration
  ## then migrate your database.

  # config.allow_attachments_for_contact_messages = false
      out
      insert_into_file 'config/initializers/trim.rb', out, :after => "  # Use this file to override Trim's default settings."
    end

    def migrate
      say 'Running rake db:migrate', MESSAGE_COLOR

      unless system 'rake db:migrate'
        say "There was an error finalizing the install. 'rake db:migrate' failed", ERROR_COLOR
      end
    end

  end
end
