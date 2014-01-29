Rails.application.routes.draw do
  resources :contact_messages, :only => :create
end
