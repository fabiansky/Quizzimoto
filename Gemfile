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
gem 'google-api-client', '~> 0.4.0', :require => 'google/api_client'
gem 'signet', '~> 0.3.0', :require => 'signet/oauth_2/client'
gem 'httpadapter', :require => 'httpadapter/adapters/net_http'
gem 'countries'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :test, :development do
  gem 'rspec-rails', '~> 2.6'
  gem 'capybara'

  # I find these two to be helpful during development.  However, ruby-debug19
  # always gives me a hard time.  Feel free to comment out either or both of
  # these.
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'pry'

  gem 'factory_girl_rails', '~> 1.2'
end

# webmock gets in the way of normal development.
group :test do
  gem 'webmock'
end