# This code is intended to be used **for training purposes only**.
require 'json'
require 'rest-client'
require 'date'

class LoginController < ApplicationController
  # def callback
  #   # Grab the value of the authorization code returned by Procore
  #   @authorization_code = params["code"]

  #   # Populate the request body with the defined parameters from the docs
  #   # Reference documentation: https://developers.procore.com/reference/authentication
  #   request = {
  #     grant_type: "authorization_code",
  #     client_id: ENV['CLIENT_ID'],
  #     client_secret: ENV['CLIENT_SECRET'],
  #     code: @authorization_code,
  #     redirect_uri: ENV['REDIRECT_URI']
  #   }

  #   # Send a request for an access token to Procore and store the response in a session variable
  #   response = RestClient.post(ENV['OAUTH_URL'] +'/oauth/token', request.to_json, { content_type: :json, accept: :json })
  #   session[:oauth_response] = JSON.parse(response)

  #   # Redirect the user's browser to the intended home page
  #   redirect_to users_home_path, success: "You have successfully obtained an access token!"

  #   rescue RestClient::ExceptionWithResponse
  #     if session[:oauth_response]
  #       redirect_to users_home_path, danger: "Something went wrong. Please refresh your access token and try again."
  #     else
  #       redirect_to login_index_path, danger: "Something went wrong. Please try again."
  #     end
  #   end

  def callback
    auth_hash = request.env['omniauth.auth']['credentials']
    token = Procore::Auth::Token.new(
      access_token: auth_hash['token'],
      refresh_token: auth_hash['refresh_token'],
      expires_at: auth_hash['expires_at']
    )

    store = Procore::Auth::Stores::Session.new(session: session)
    store.save(token)
    redirect_to users_home_path, success: "Access token granted."
  rescue Procore::Error
    redirect_to login_index_path, danger: "Something went wrong. Please try again."
  end


  def refresh
      # Send a request to refresh the access token to Procore and store the response
      client.refresh
      # Redirect the user's browser to the intended home page
      redirect_to users_home_path, success: "Access token refreshed successfully."
    rescue Procore::Error
      redirect_to login_index_path, danger: "Something went wrong. Please try again."

    # # Populate the request body with the defined parameters from the docs
    # # Reference documentation: https://developers.procore.com/reference/authentication
    # request = {
    #   grant_type: "refresh_token",
    #   client_id: ENV['CLIENT_ID'],
    #   client_secret: ENV['CLIENT_SECRET'],
    #   refresh_token: session[:oauth_response]['refresh_token'],
    #   redirect_uri: ENV['REDIRECT_URI']
    # }

    # # Send a request for an access token to Procore and store the response in a session variable
    # response = RestClient.post(ENV['OAUTH_URL'] + '/oauth/token', request.to_json, { content_type: :json, accept: :json })
    # session[:oauth_response] = JSON.parse(response)

    # # Redirect the user's browser to the intended home page
    # redirect_to users_home_path, success: "You have successfully refreshed your access token!"

    # rescue RestClient::ExceptionWithResponse
    #   if session[:oauth_response]
    #     redirect_to users_home_path, danger: "Something went wrong. Please refresh your access token and try again."
    #   else
    #     redirect_to login_index_path, danger: "Something went wrong. Please try again."
    #   end
    end

  def revoke
    # Send a request to revoke the access token to Procore
    client.revoke
    # Deletes current session to clear out session variables
    reset_session
    # Redirects user back to the login page
    redirect_to login_index_path, success: "Access token revoked successfully."
  rescue Procore::Error
    redirect_to login_index_path, danger: "Something went wrong. Please try again."
  end
end
