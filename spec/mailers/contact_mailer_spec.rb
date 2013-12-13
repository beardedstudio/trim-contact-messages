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

  context 'with attachment' do
    before :each do
      Trim::ContactMailer.any_instance.stub(:read_attachment) do
        File.read(get_attachment_file)
      end

      @setting = Trim::Setting.first || Trim::Setting.make!
      @message  = Trim::ContactMessage.make! :with_attachment
    end

    it 'should send the attachment with the email' do
      @mail = Trim::ContactMailer.contact_email(@message)

      @mail.attachments.should have(1).attachment
      
      attachment = @mail.attachments[0]
      attachment.content_type.should be_start_with('application/pdf')
      attachment.filename.should == 'test-pdf.pdf'
    end

  end

end
