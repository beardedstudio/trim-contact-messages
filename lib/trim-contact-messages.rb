require 'trim'
require 'rakismet'

module Trim

  module ContactMessages
    # Renderers
    require 'trim/contact-messages/liquid/tags/contact_form.rb'
  end

  Trim.setup do |config|
    config.setting_email_keys[:user_contact_message_confirmation_email] = [:name, :email, :subject, :message, :phone]
  end

  Trim.module_eval do
    mattr_accessor :fooderp
    @@fooderp = 'blerrch'
  end

end

require 'generators/trim/contact_messages_generator'
require 'trim/contact-messages/engine'
