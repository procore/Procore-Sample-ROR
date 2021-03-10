# This code is intended to be used **for training purposes only**.
require 'json'
require 'rest-client'
require 'date'

class LoginController < ApplicationController
  rescue_from Procore::Error do |exception|
    redirect_to login_index_path, danger: "Something went wrong. Please try again."
  end

  def callback
    # Create an auth token
    auth_hash = request.env['omniauth.auth']['credentials']
    token = Procore::Auth::Token.new(
      access_token: auth_hash['token'],
      refresh_token: auth_hash['refresh_token'],
      expires_at: auth_hash['expires_at']
    )

    # Save the token in a session variable
    store = Procore::Auth::Stores::Session.new(session: session)
    store.save(token)

    # Redirect the user's browser to the intended home page
    redirect_to users_home_path, success: "Access token granted."
  end


  def refresh
      # Send a request to refresh the access token to Procore and store the response
      client.refresh

      # Redirect the user's browser to the intended home page
      redirect_to users_home_path, success: "Access token refreshed successfully."
    end

  def revoke
    # Send a request to revoke the access token to Procore
    client.revoke

    # Deletes current session to clear out session variables
    reset_session

    # Redirects user back to the login page
    redirect_to login_index_path, success: "Access token revoked successfully."
  end
end
