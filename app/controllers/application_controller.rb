# Copyright 2012 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class ApplicationController < ActionController::Base
  class AuthorizationError < RuntimeError; end

  before_filter :setup_oauth2
  protect_from_forgery
  helper_method :logged_in?, :current_user_profile, :current_user_id
  rescue_from AuthorizationError, Signet::AuthorizationError,
    :with => :handle_authorization_error

  protected

    attr_accessor :google_client

    # At the beginning of the request, make sure the OAuth token is available.
    # If it's not available, kick off the OAuth2 flow to authorize.
    def setup_oauth2
      @google_client = Google::APIClient.new(
        :authorization => :oauth_2,
        :http_adapter  => HTTPAdapter::NetHTTPAdapter.new
      )

      @google_client.authorization.client_id     = APP_CONFIG['oauth2']['client_id']
      @google_client.authorization.client_secret = APP_CONFIG['oauth2']['client_secret']
      @google_client.authorization.scope         = APP_CONFIG['oauth2']['scopes']
      @google_client.authorization.redirect_uri  = oauth2_callback_url
      @google_client.authorization.code          = params[:code] if params[:code]

      # Load the access token here if it's available.
      if session[:oauth2_token]
        @google_client.authorization.update_token!(session[:oauth2_token])
      end

      unless @google_client.authorization.access_token || request.path_info =~ /^\/oauth2/
        redirect_to oauth2_authorize_url
      end
    end

    def signet_client
      google_client.authorization
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
        plus = google_client.discovered_api('plus')
        response = google_client.execute(plus.people.get, :userId => 'me')
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
    #   response = google_client.execute(plus.people.get, :userId => 'me')
    #   raise AuthorizationError if response.status == 401
    #
    # You don't need to do this for
    # signet_client.fetch_protected_resource since Signet will
    # automatically raies a Signet::AuthorizationError.
    def handle_authorization_error
      session[:oauth2_token] = nil
      flash[:notice] = %q{
        Your session has expired.  Please log in again to continue.
      }
      redirect_to oauth2_authorize_url
    end

    # This wraps Signet's fetch_protected_resource method and adds the
    # X-GData-Key header.
    #
    # This is basically the only thing YouTube specific that is needed to use
    # Signet with YouTube.
    def fetch_youtube_resource(options = {})
      options[:headers] ||= {}
      options[:headers]['X-GData-Key'] ||= 'key=' + APP_CONFIG['youtube']['dev_key']
      signet_client.fetch_protected_resource(options)
    end
end
