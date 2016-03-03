Rails.application.routes.draw do
  devise_for :users, controllers:{
  	omniauth_callbacks:'users/omniauth_callbacks'
  }
  root 'main#home'

  post '/custom_sign_up' => 'users/omniauth_callbacks#custom_sign_up'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
