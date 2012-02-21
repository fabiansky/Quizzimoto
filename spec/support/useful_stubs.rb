# Do all the stubbing and visiting necessary to simulate a login using
# Capybara.
def login
  body = MultiJson.encode({
    'access_token'  => '12345',
    'refresh_token' => '54321',
    'expires_in'    => '3600'
  })
  
  stub_request(:post, 'https://accounts.google.com/o/oauth2/token').with(
    :body => {
      'grant_type'    => 'authorization_code',
      'code'          => 'code',
      'redirect_uri'  => oauth2_callback_url,
      'client_id'     => APP_CONFIG['oauth2']['client_id'],
      'client_secret' => APP_CONFIG['oauth2']['client_secret']
    }).to_return(:body => body)

  visit oauth2_callback_url(:code => 'code')
end

# Execute the following to simulate a validly logged in session:
#
#   session[:oauth2_token] = valid_login_token
def valid_login_token
  {'access_token'  => '12345',
   'refresh_token' => '54321',
   'expires_in'    => '3600',
   'issued_at'     => Time.now}
end

# www.googleapis.com/discovery/v1/apis/plus/v1/rest
def stub_plus_discovery_document
  filename = Rails.root.join(
    'spec/support/documents/www.googleapis.com/discovery/v1/apis/plus/v1/rest')
  stub_request(:get, 'https://www.googleapis.com/discovery/v1/apis/plus/v1/rest').
    to_return(:body => IO.read(filename))
end

# www.googleapis.com/plus/v1/people/me
def stub_current_user_profile
  filename = Rails.root.join(
    'spec/support/documents/www.googleapis.com/plus/v1/people/me')
  stub_request(:get, 'https://www.googleapis.com/plus/v1/people/me').
    with(:headers => {'Authorization'=>'Bearer 12345'}).
    to_return(:body => IO.read(filename))
end

# gdata.youtube.com/feeds/api/videos/0HYHG3fuzvk?alt=jsonc&v=2
def stub_video_entry
  filename = Rails.root.join(
    'spec/support/documents/gdata.youtube.com/feeds/api/videos/0HYHG3fuzvk?alt=jsonc&v=2')
  stub_request(:get, 'https://gdata.youtube.com/feeds/api/videos/0HYHG3fuzvk?alt=jsonc&v=2').
    with(:headers =>
      {'Authorization' => 'Bearer 12345',
       'X-Gdata-Key'   => 'key=AI39si7sYNfF3-xVbZUalnyU-0CjvnwucP0u4edZ_uCm02GaM8RajpeTBJ3LWprdw_THhdvDNwjy2UPO4dCH3a0LG8B25cQnkQ'}).
    to_return(:status => 200, :body => IO.read(filename))
end