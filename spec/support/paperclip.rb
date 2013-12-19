RSpec.configure do |config| 
  config.before :each do    
    Paperclip::Attachment.any_instance.stub(:post_process).and_return(true)
  end
end
