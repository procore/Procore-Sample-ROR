# This code is intended to be used **for training purposes only**.
Rails.application.routes.draw do

  get 'login/index'

  get 'users/me'

  get 'users/home'

  post 'login/refresh'

  get 'login/callback'

  get 'login/revoke'

  root 'login#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
