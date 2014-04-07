module Trim
  class ContactMessagesController < InheritedController
    # load_and_authorize_resource

    def create
      # Log user agent and IP address for akismet detection
      params[:contact_message][:user_agent] = request.user_agent
      params[:contact_message][:user_ip] = request.remote_ip

      @contact_message = Trim::ContactMessage.create(params[:contact_message])

      create! do |success, failure|
        
        success.html do
          flash[:notice] = "Thanks for contacting us!"
          redirect_to request.referrer.blank? ? root_path : request.referrer
        end
        
        failure.html do

          flash.now[:alert] = "There was a problem sending your message, please try again."
          
          if request.referrer.blank? 
            render 'trim/home/index'
          else
            # get path, remove leading /
            path = URI(request.referrer).path
            path[0] = ''

            nav_item = Trim::NavItem.find_by_nav_path(path)

            if nav_item.nil? || nav_item.linked.blank? 
              render 'trim/home/index'
            else
              @page = nav_item.linked
              render 'trim/pages/show', :object => @page
            end
          end
        end
      end 
    end
  end
end
