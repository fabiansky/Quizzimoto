class Oauth2Controller < ApplicationController
  def authorize
  end

  def callback
    @client.authorization.fetch_access_token!
    unless session[:token]
      session[:token] = {
        :refresh_token => @client.authorization.refresh_token,
        :access_token  => @client.authorization.access_token,
        :expires_in    => @client.authorization.expires_in,
        :issued_at     => Time.at(@client.authorization.issued_at)
      }
    end

    redirect_to root_url
  end
end
