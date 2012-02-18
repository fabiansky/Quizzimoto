require 'spec_helper'

describe Oauth2Controller do
  describe 'GET authorize' do
    it 'generates the correct authorization_uri' do
      get :authorize, {}, {}
      authorization_uri = assigns(:authorization_uri)
      params = CGI.parse(authorization_uri.query)
      params['access_type'].first.should == 'offline'
      params['approval_prompt'].first.should == 'auto'
      params['scope'].first.split.should == %w(
        https://www.googleapis.com/auth/plus.me
        http://gdata.youtube.com  
      )
    end
  end
end
