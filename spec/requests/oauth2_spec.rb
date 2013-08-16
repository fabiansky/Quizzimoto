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

require 'spec_helper'

describe 'OAuth2' do
  before(:each) do
    stub_plus_discovery_document
    stub_current_user_profile
  end

  it 'forces you to login' do
    visit '/'
    page.current_url.should == 'http://www.example.com/oauth2authorize'
    page.should have_content('This application lets you build video-based quizzes')
    page.should have_content('Login to continue')
  end

  it 'lets you view the home page if you login' do
    login
    page.current_url.should == 'http://www.example.com/'
    page.should have_content('This application lets you build video-based quizzes')
    page.should_not have_content('Login to continue')
  end

  context '/oauth2callback' do
    it 'crashes unless you pass a code parameter' do
      lambda { visit '/oauth2callback' }.should raise_exception(ArgumentError)
    end
  end

  it 'allows you to logout' do
    login
    page.should have_content('Shannon Behrens')
    click_link 'Logout'
    page.current_url.should == 'http://www.example.com/oauth2authorize'
    page.should have_content('You are now logged out.')
    page.should have_content('Login to continue')
    page.should_not have_content('Shannon Behrens')
  end
end