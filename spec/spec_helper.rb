# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

# Do all the mocking and visiting necessary to simulate a login using
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
#   session[:token] = valid_login_token
def valid_login_token
  { 'access_token'  => '12345',
    'refresh_token' => '54321',
    'expires_in'    => '3600',
    'issued_at'     => Time.now }
end