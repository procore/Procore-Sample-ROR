# This code is intended to be used **for training purposes only**.
class UsersController < ApplicationController

  def me
    # # Send a request to the Show User Info endpoint
    # # Reference documentation: https://developers.procore.com/reference/me
    # get_me = RestClient.get(ENV['BASE_URL'] +'/vapid/me',
    #         { Authorization: "Bearer #{session[:oauth_response]['access_token']}" })

    # # Store the parsed response in an instance variable
    # @me = JSON.parse(get_me)

    # rescue RestClient::ExceptionWithResponse
    #   if session[:oauth_response]
    #     redirect_to users_home_path, danger: "Something went wrong. Please check or refresh your access token and try again."
    #   else
    #     redirect_to login_index_path, danger: "Something went wrong. Please try again."
    #   end
  end

  def home
    # Fetch the access token from the previously-set session variable and store
    # the value in an instance variable
    procore_token = JSON.parse(session['procore_token']) 
    @access_token = procore_token['access_token']

    # Fetch the 'expires_at' value from the session variable, subtract it from the
    # current time to find the time until the access token will expire,
    # and store the new 'expires_in' value in an instance variable
    expires_at = procore_token['expires_at']
    @pretty_expires_at = Time.at(expires_at).asctime
    @expires_in = expires_at - Time.now.to_i

    # # Fetch the access token from the session variable and store the value in
    # # an instance variable
    @refresh_token = procore_token['refresh_token']

    # # If proxy Procore request params are present, make the request
    # if params[:path]
    #   begin
    #     @resp = procore_request(@access_token, params[:path], params[:method], params[:body])
    #   rescue => e
    #     @resp = e.message
    #   end
    # end

    # rescue RestClient::ExceptionWithResponse
    #   if session[:oauth_response]
    #     redirect_to users_home_path, danger: "Something went wrong. Please refresh your access token and try again."
    #   else
    #     redirect_to login_index_path, danger: "Something went wrong. Please try again."
    # end
  end

  private

  def procore_request(token, path, method, body)
    # resp = case method
    #   when 'post'
    #     RestClient.post(
    #       ENV['BASE_URL'] + path,
    #       body ? JSON.parse(body) : nil,
    #       { Authorization: "Bearer #{session[:oauth_response]['access_token']}" }
    #     )
    #   when 'get'
    #     resp = RestClient.get(
    #       ENV['BASE_URL'] + path,
    #       { Authorization: "Bearer #{session[:oauth_response]['access_token']}" }
    #     )
    #   else
    #     ''
    # end


    # JSON.parse(resp)
  end
end
