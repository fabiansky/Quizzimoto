class Oauth2Controller < ApplicationController
  def authorize
    @authorization_uri = @client.authorization.authorization_uri(
      :approval_prompt => 'auto')
  end

  def callback
    @client.authorization.fetch_access_token!
    unless session[:oauth2_token]
      session[:oauth2_token] = {
        :refresh_token => @client.authorization.refresh_token,
        :access_token  => @client.authorization.access_token,
        :expires_in    => @client.authorization.expires_in,
        :issued_at     => Time.at(@client.authorization.issued_at)
      }
    end

    redirect_to root_url
  end
end
