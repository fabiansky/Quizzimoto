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

describe 'This project' do
  it 'uses RSpec instead of TestUnit' do
    Dir.exist?(File.join(File.dirname(__FILE__), '..', 'test')).should be_false
    Dir.exist?(File.join(File.dirname(__FILE__), '..', 'spec')).should be_true
  end

  it 'prefers request specs with Capybara over view specs' do
     Dir.exist?(File.join(File.dirname(__FILE__), 'views')).should be_false
     Dir.exist?(File.join(File.dirname(__FILE__), 'requests')).should be_true
   end

  it 'uses the countries gem' do
    Country.new('US').should_not be_nil
  end
end