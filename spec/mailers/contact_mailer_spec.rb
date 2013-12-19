describe 'Trim::ContactMailer' do

  context 'without attachment' do
    before :each do
      @setting = Trim::Setting.first || Trim::Setting.make!
      @message  = Trim::ContactMessage.make!
    end

    it 'should generate a message to the designated admin when a contact message is created' do 
      @mail = Trim::ContactMailer.contact_email(@message)

      @mail.to.include?(@message.contact_subject.email).should be_true
      @mail.body.should match(@message.name)
      @mail.body.should match(@message.email)
      @mail.body.should match(@message.phone)
      @mail.body.should match(@message.contact_subject.name)
      @mail.body.should match(@message.message)
    end
      
    it 'should generate a confirmation email to the submitter' do
      @mail = Trim::ContactMailer.confirm_email(@message)

      @mail.to.include?(@message.email).should be_true
      @mail.body.should match(@message.name)
      @mail.body.should match(@message.phone)
      @mail.body.should match(@message.message)
    end
  end

end
