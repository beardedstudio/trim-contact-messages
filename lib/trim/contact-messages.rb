require 'trim'
require 'rakismet'

module Trim
  module ContactMessages
    # Renderers
    require 'trim/contact-messages/liquid/tags/contact_form.rb'
  end
end

require 'generators/trim/contact_messages_generator'
require 'trim/contact-messages/engine'
