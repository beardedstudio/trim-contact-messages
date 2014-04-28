module Trim
  class ContactMessagesController < InheritedController
    # load_and_authorize_resource

    def create
      # Log user agent and IP address for akismet detection
      params[:contact_message][:user_agent] = request.user_agent
      params[:contact_message][:user_ip] = request.remote_ip

      @contact_message = Trim::ContactMessage.create(params[:contact_message], :as => :admin)

      create! do |success, failure|       
        success.html do
          flash[:notice] = "Thanks for contacting us!"
          redirect_to redirect_destination
        end
        
        failure.html do
          flash[:alert] = "There was a problem sending your message, please try again."
          redirect_to redirect_destination
        end
      end 
    end

    def redirect_destination
      if session.key?(:return_to_contact_form) && !session[:return_to_contact_form].blank?
        session[:return_to_contact_form]
      elsif !request.referrer.blank?
        request.referrer
      else
        root_path
      end
    end

  end
end
