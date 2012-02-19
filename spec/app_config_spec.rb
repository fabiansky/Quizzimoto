require 'spec_helper'

describe APP_CONFIG do
  it 'has OAuth2 configuration' do
    APP_CONFIG['oauth2']['client_id'].should_not be_nil
    APP_CONFIG['oauth2']['client_secret'].should_not be_nil
    APP_CONFIG['oauth2']['scopes'].should_not be_nil
  end

  it 'has YouTube configuration' do
    APP_CONFIG['youtube']['dev_key'].should_not be_nil
  end
end