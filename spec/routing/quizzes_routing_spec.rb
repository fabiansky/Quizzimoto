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

require "spec_helper"

describe QuizzesController do
  describe "routing" do

    it "routes to #index" do
      get("/quizzes").should route_to("quizzes#index")
    end

    it "routes to #new" do
      get("/quizzes/new").should route_to("quizzes#new")
    end

    it "routes to #show" do
      get("/quizzes/1").should route_to("quizzes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/quizzes/1/edit").should route_to("quizzes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/quizzes").should route_to("quizzes#create")
    end

    it "routes to #update" do
      put("/quizzes/1").should route_to("quizzes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/quizzes/1").should route_to("quizzes#destroy", :id => "1")
    end

  end
end
