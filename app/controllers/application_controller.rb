# This code is intended to be used **for training purposes only**.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :danger, :success

end
