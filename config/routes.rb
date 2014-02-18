Rails.application.routes.draw do
  scope module: 'trim' do
    resources :contact_messages, :only => :create
  end
end
