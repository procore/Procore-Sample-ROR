# This code is intended to be used **for training purposes only**.
Rails.application.routes.draw do
  root 'login#index'

  namespace :login do
    get 'index'
    post 'refresh'
    get 'callback'
    get 'revoke'
  end

  namespace :users do
    get 'me'
    get 'home'
  end

  get 'auth/procore/callback', to: 'login#callback'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
