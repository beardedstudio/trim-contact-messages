describe Trim::ContactAttachment do

  it { should validate_attachment_size(:attachment).less_than(5.megabytes) }

  it { should validate_attachment_content_type(:attachment).
                allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg', 'application/pdf').
                rejecting('text/plain', 'text/xml', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') }

end
