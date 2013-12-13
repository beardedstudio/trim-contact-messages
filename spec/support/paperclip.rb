RSpec.configure do |config| 
  config.before :each do
    Trim::ContactAttachment.any_instance.stub(:save_attached_files).and_return(true)
    Trim::ContactAttachment.any_instance.stub(:delete_attached_files).and_return(true)
    
    Paperclip::Attachment.any_instance.stub(:post_process).and_return(true)
  end
end
