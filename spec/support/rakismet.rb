RSpec.configure do |config| 
  config.before :each do
    Trim::ContactMessage.any_instance.stub(:send_to_akismet).and_return(true)
  end
end