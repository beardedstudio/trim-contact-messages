require 'trim'
require 'rakismet'

module TrimContactMessages
  # Renderers
  require 'trim-contact-messages/liquid/tags/contact_form.rb'
end

require 'generators/trim/contact_messages_generator'
require 'trim-contact-messages/engine'
