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

class Oauth2Controller < ApplicationController
  def authorize
    @authorization_uri = signet_client.authorization_uri(
      :approval_prompt => 'auto'
      )
  end

  def callback
    signet_client.fetch_access_token!
    unless session[:oauth2_token]
      session[:oauth2_token] = {
        :refresh_token => signet_client.refresh_token,
        :access_token  => signet_client.access_token,
        :expires_in    => signet_client.expires_in,
        :issued_at     => Time.at(signet_client.issued_at)
      }
    end

    redirect_to root_url
  end

  def logout
    reset_session
    flash[:notice] = 'You are now logged out.'
    redirect_to oauth2_authorize_url
  end
end
