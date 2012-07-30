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

describe 'Layout' do
  before(:each) do
    stub_plus_discovery_document
    stub_current_user_profile
  end
  
  it 'has a link to the homepage' do
    login
    click_link 'Quizzimoto'
    page.current_url.should == 'http://www.example.com/'
  end

  it 'shows stuff specific to the current user' do
    login
    page.should have_content('Shannon Behrens')
    page.should have_css('#profile_pic img')
  end
end