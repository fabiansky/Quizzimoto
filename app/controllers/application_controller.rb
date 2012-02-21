class ApplicationController < ActionController::Base
  class AuthorizationError < RuntimeError; end

  before_filter :setup_oauth2
  protect_from_forgery
  helper_method :logged_in?, :current_user_profile, :current_user_id
  rescue_from AuthorizationError, Signet::AuthorizationError,
    :with => :handle_authorization_error

  protected

    # At the beginning of the request, make sure the OAuth token is available.
    # If it's not available, kick off the OAuth2 flow to authorize.
    def setup_oauth2
      @client = Google::APIClient.new(
        :authorization => :oauth_2,
        :http_adapter  => HTTPAdapter::NetHTTPAdapter.new
      )

      @client.authorization.client_id     = APP_CONFIG['oauth2']['client_id']
      @client.authorization.client_secret = APP_CONFIG['oauth2']['client_secret']
      @client.authorization.scope         = APP_CONFIG['oauth2']['scopes']
      @client.authorization.redirect_uri  = oauth2_callback_url
      @client.authorization.code          = params[:code] if params[:code]

      # Load the access token here if it's available.
      if session[:oauth2_token]
        @client.authorization.update_token!(session[:oauth2_token])
      end

      unless @client.authorization.access_token || request.path_info =~ /^\/oauth2/
        redirect_to oauth2_authorize_url
      end
    end

    # Is the current user logged in?
    def logged_in?
      session[:oauth2_token] != nil
    end

    # Return the current user's Google+ profile.
    #
    # Cache it in the session to avoid running into quota issues.
    def current_user_profile
      unless session[:current_user_profile]
        plus = @client.discovered_api('plus')
        response = @client.execute(plus.people.get, :userId => 'me')
        raise AuthorizationError if response.status == 401
        session[:current_user_profile] = JSON.parse(response.body)
      end
      session[:current_user_profile]
    end

    # Return the current user's Google+ ID.
    def current_user_id
      current_user_profile['id']
    end

    # Handle 401s.
    #
    # If a web service call results in a 401, it probably means the user's
    # OAuth2 access token has expired.  Clear his session[:token] and ask him
    # to log in again.
    #
    # HACK: This code could be a lot smarter.  It could try to refresh the
    # access token.  I'm going to punt on that until this issue is resolved:
    # http://code.google.com/p/google-api-ruby-client/issues/detail?id=12&q=401
    #
    # Here's an example of using this method:
    #
    #   response = @client.execute(plus.people.get, :userId => 'me')
    #   raise AuthorizationError if response.status == 401
    def handle_authorization_error
      session[:oauth2_token] = nil
      flash[:notice] = %q{
        Your session has expired.  Please log in again to continue.
      }
      redirect_to oauth2_authorize_url
    end
end
