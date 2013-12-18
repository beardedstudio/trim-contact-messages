class ContactForm < Liquid::Tag

  def initialize(tag_name, index, tokens)
    super
  end

  def render(context)
    ctrl = context.environments.first[:controller]
    args = Trim.allow_attachments_for_contact_messages ? {:attachments => [Trim::ContactAttachment.new]} : {}
    
    ctrl.send(:render_to_string, :partial => 'trim/contact_messages/form', :locals => { :message => Trim::ContactMessage.new( args ) })
  end

end

Liquid::Template.register_tag('contact_form', ContactForm)
