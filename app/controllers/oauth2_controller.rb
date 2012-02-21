class Oauth2Controller < ApplicationController
  def authorize
    @authorization_uri = signet_client.authorization_uri(
      :approval_prompt => 'auto')
  end

  def callback
    signet_client.fetch_access_token!
    unless session[:oauth2_token]
      session[:oauth2_token] = {
        :refresh_token => signet_client.refresh_token,
        :access_token  => signet_client.access_token,
        :expires_in    => signet_client.expires_in,
        :issued_at     => Time.at(signet_client.issued_at)
      }
    end

    redirect_to root_url
  end

  def logout
    reset_session
    flash[:notice] = 'You are now logged out.'
    redirect_to oauth2_authorize_url
  end
end
