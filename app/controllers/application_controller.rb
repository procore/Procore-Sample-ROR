# This code is intended to be used **for training purposes only**.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :danger, :success, :warning

  def client
    @client ||= Procore::Client.new(
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      store: store = Procore::Auth::Stores::Session.new(session: session),
      options: { host: ENV['BASE_URL'] }
    )
  end
end
