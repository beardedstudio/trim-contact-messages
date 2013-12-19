describe Trim::ContactMessage do

  describe 'emails' do

    before :each do
      @setting = Trim::Setting.first || Trim::Setting.make!
      @last_email = ActionMailer::Base.deliveries.last
      @message = Trim::ContactMessage.make!
    end

    before :each do
      @confirmation = ActionMailer::Base.deliveries[-2]
      @notification = ActionMailer::Base.deliveries[-1]
    end

    it 'should send emails' do
      @confirmation.should_not == @last_email
      @notification.should_not == @last_email

      @confirmation.to.should == [@message.email]
      @notification.to.should == [@message.contact_subject.email]
    end

  end
  
end