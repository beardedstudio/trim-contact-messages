require 'machinist/active_record'

Trim::ContactAttachment.blueprint do
  attachment { get_attachment_file }
end

Trim::ContactMessage.blueprint do
  contact_subject { Trim::ContactSubject.make! }
  name { "Submitter Name #{sn}" }
  email { "form.submitter.#{sn}@example.com" }
  message { "Just sending you a little message to say hi." }
  phone { '000.000.0000' }
  user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11' }
  user_ip { '127.0.0.1' }
end

Trim::ContactMessage.blueprint :with_attachment do
  attachments { [ Trim::ContactAttachment.make ] }
end

Trim::ContactSubject.blueprint do
  name { "Contact Subject #{sn}" }
  email { "message.admin.#{sn}@example.com" }
end

Trim::Page.blueprint do
  title { "Page #{sn}" }
  body { 'Lorem ipsum dolor' }
end

Trim::Page.blueprint :with_contact_form do 
  body { 'This page body has a form in it! {% contact_form %}'}
end

Trim::Setting.blueprint do
  twitter_name { 'beardedstudio' }
  facebook_url { 'https://www.facebook.com/beardedstudio' }
  street_address { '6101 Penn Avenue, Suite 302' }
  city { 'Pittsburgh' }
  state { 'PA' }
  zip_code { '15206' }
  phone_number { '412.376.7273' }
  contact_email { 'info@bearded.com' }
  meta_description { 'A Pittsburgh, PA-based Web Design and Development Studio' }
  meta_keywords { 'Beard, Internet, Web, Doge, Website' }

  Trim::Setting.email_configuration.each do |name, params|
    send("#{name}_body") { Trim::Setting.email_placeholder_string name }
    send("#{name}_subject") { name }
  end
end
