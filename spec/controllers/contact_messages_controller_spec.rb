describe Trim::ContactMessagesController do

  describe "create" do

    before :each do
      @subject = Trim::ContactSubject.make!
      @message_params = { :contact_message => {
        'contact_subject_id' => @subject.id,
        'name' => 'Testy Testertson',
        'email' => 'test@example.com',
        'message' => 'Lorem ipsum boo.'
      }}

    end

    it 'should create a contact message' do
      post :create, @message_params

      assigns(:contact_message).name.should eq(@message_params[:contact_message]['name'])
    end

    it 'should redirect_to session[:return_to_contact_form] if set' do
      session[:return_to_contact_form] = '/foo/bar'
      post :create, @message_params

      response.should redirect_to '/foo/bar'
    end

    it 'should redirect_to request.referrer if session[:return_to_contact_form] is not set' do
      session[:return_to_contact_form] = nil
      request.stub(:referrer).and_return '/baz/bogus'
      post :create, @message_params

      response.should redirect_to '/baz/bogus'
    end

    it 'should redirect_to root path if neither session[:return_to_contact_form] nor request.referrer are set' do
      session[:return_to_contact_form] = nil
      request.stub(:referrer).and_return nil
      post :create, @message_params

      response.should redirect_to root_path
    end

  end

end
