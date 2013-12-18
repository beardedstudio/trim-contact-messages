class ContactForm < Liquid::Tag

  def initialize(tag_name, index, tokens)
    super
  end

  def render(context)
    ctrl = context.environments.first[:controller]
    
    ctrl.send(:render_to_string, :partial => 'trim/contact_messages/form', :locals => { :message => Trim::ContactMessage.new })
  end

end

Liquid::Template.register_tag('contact_form', ContactForm)
