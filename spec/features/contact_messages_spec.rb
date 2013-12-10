describe Trim::ContactMessage do

  context "rendering" do
    before :each do
      Trim::ContactSubject.make!
      @page = Trim::Page.make! :with_contact_form
      visit page_path @page
    end

    it 'should render the contact form' do
      within '#primary .main-content' do
        page.should have_css 'form#new_contact_message'
      end
    end

    it 'should render the name field' do
      within 'form#new_contact_message' do
        page.should have_css 'input[type="text"]#contact_message_name'
      end
    end

    it 'should render the email field' do
      within 'form#new_contact_message' do
        page.should have_css 'input[type="email"]#contact_message_email'
      end
    end

    it 'should render the phone field' do
      within 'form#new_contact_message' do
        page.should have_css 'input[type="tel"]#contact_message_phone'
      end
    end

    it 'should render the subject field' do
      within 'form#new_contact_message' do
        page.should have_css 'select#contact_message_contact_subject_id'
      end
    end

    it 'should render the message field' do
      within 'form#new_contact_message' do
        page.should have_css 'textarea#contact_message_message'
      end
    end

    it 'should render one attachment field' do
      within 'form#new_contact_message' do
        page.should have_css 'fieldset#contact_message_attachments'
        within '#contact_message_attachments' do
          page.should have_css 'input[type="file"]', :count => 1
        end
      end
    end

    it 'should render the submit button' do
      within 'form#new_contact_message' do
        page.should have_css 'input[type="submit"]'
      end
    end

  end # /rendering

  context "submission" do
    before :each do
      Trim::ContactSubject.make!
      @page = Trim::Page.make! :with_contact_form
      visit polymorphic_path @page
    end

    it 'should display a success message on valid submission'  do
      fill_in_form
      click_button 'Contact Us!'
      messages "Thanks for contacting us!", "success"
    end

    it 'should display an error message when email is absent' do
      fill_in_form
      fill_in 'contact_message_email', :with => ''
      click_button 'Contact Us!'
      messages "There was a problem sending your message, please try again.", "error"
    end

    it 'should display an error message if message is blank' do
      fill_in_form
      fill_in 'contact_message_message', :with => ''
      click_button 'Contact Us!'
      messages "There was a problem sending your message, please try again.", "error"
    end

    it 'should display an error message if an invalid attachment is uploaded' do
      fill_in_form

      path = Rails.root.join("spec/support/test-docx.docx")
      attach_file("contact_message_attachments_attributes_0_attachment", path)

      click_button 'Contact Us!'
      messages "You've added an invalid attachment file, please try again.", "error"
    end
  end # /submission

end

def fill_in_form
  fill_in 'contact_message_name', :with => 'Why?'
  fill_in 'contact_message_email', :with => 'test@example.com'
  select  Trim::ContactSubject.first.name, :from => 'contact_message_contact_subject_id'
  fill_in 'contact_message_phone', :with => '412-555-1212'
  fill_in 'contact_message_message', :with => 'Crunchy Bacon?'
end

def messages(text, css_class=nil)
  within "section.messages" do
    page.should have_content text
    if !css_class.blank?
      page.should have_css "div.#{css_class}"
    end
  end
end
