source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
gem 'google-api-client', :require => 'google/api_client'
gem 'httpadapter', :require => 'httpadapter/adapters/net_http'
gem 'countries'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :test, :development do
  gem 'rspec-rails', '~> 2.6'
  gem 'capybara'

  # I find these two to be helpful during development.  However, I had a hard
  # time getting ruby-debug19 running under MacPorts.  Feel free to comment out
  # these two lines.
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'pry'
end

# webmock gets in the way of normal development.
group :test do
  gem 'webmock'
end