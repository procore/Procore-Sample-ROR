# This code is intended to be used **for training purposes only**.
class UsersController < ApplicationController
  before_action :ensure_logged_in

  def me
    # Send a request to the Show User Info endpoint
    request = client.get('me')

    # Store the parsed response in an instance variable
    @me = request.body

  rescue Procore::Error => e
    flash[:danger] = "#{e.class}: #{e.message}"
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

    # Fetch the access token from the session variable and store the value in
    # an instance variable
    @refresh_token = procore_token['refresh_token']

    # If proxy Procore request params are present, make the request
    if params[:path]
      begin
        @resp = procore_request(@access_token, params[:path], params[:method], params[:body], params[:version])
      rescue => e
        @resp = "#{e.class}: #{e.message}"
      end
    end
  end

  def ensure_logged_in
    unless session['procore_token'] 
      redirect_to login_index_path, warning: "Please log in."
    end
  end

  private

  def procore_request(token, path, method, body, version)
    version = nil if version.empty?

    resp = case method
      when 'get'
        client.get path, version: version
      when 'post'
        client.post path, body: JSON.parse(body), version: version
      when 'patch'
        client.patch path, body: JSON.parse(body), version: version
      when 'delete'
        client.delete path, body: JSON.parse(body), version: version
    end

    resp.body
  end
end
