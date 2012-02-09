class ApplicationController < ActionController::Base
  before_filter :setup_oauth2
  protect_from_forgery

  protected

    # At the beginning of the request, make sure the OAuth token is available.
    # If it's not available, kick off the OAuth2 flow to authorize.
    def setup_oauth2
      @client = Google::APIClient.new(
        :authorization => :oauth_2,
        :host          => 'www.googleapis.com',
        :http_adapter  => HTTPAdapter::NetHTTPAdapter.new
      )

      @client.authorization.client_id     = APP_CONFIG['oauth2']['client_id']
      @client.authorization.client_secret = APP_CONFIG['oauth2']['client_secret']
      @client.authorization.scope         = APP_CONFIG['oauth2']['scopes']
      @client.authorization.redirect_uri  = oauth2_callback_url
      @client.authorization.code          = params[:code] if params[:code]

      # Load the access token here if it's available.
      if session[:token]
        @client.authorization.update_token!(session[:token])
      end

      unless @client.authorization.access_token || request.path_info =~ /^\/oauth2/
        redirect_to oauth2_authorize_url
      end
    end
end
