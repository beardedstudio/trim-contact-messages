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

  describe 'with attachments' do

    it 'should create attachments if present' do
      @message = Trim::ContactMessage.make! :with_attachment
      @message.attachments.count.should == 1
    end

    it 'should destroy any attachments if flagged as spam' do
      Trim::ContactMessage.any_instance.stub(:is_spam).and_return(true)

      attachment = Trim::ContactAttachment.make( :attachment => (File.new Rails.root.join("../support/test-image.jpg")) )
      @message = Trim::ContactMessage.make! :attachments => [attachment]

      @message.attachments.count.should == 0
      expect { Trim::ContactAttachment.find(attachment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
  
end