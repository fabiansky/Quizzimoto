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

class CreateQuizzes < ActiveRecord::Migration
  def self.up
    # A quiz is a YouTube playlist with a set of questions attached.
    create_table :quizzes do |t|

      # The playlist also has a name, but I don't want to have to talk to
      # YouTube just to get it.  I'm okay with denormalizing in this case.  I
      # don't care if the user renames the playlist on YouTube behind my back.
      t.string :name, :null => false

      # This is the YouTube playlist ID.  It's a string.
      t.string :playlist_id, :null => false

      t.integer :min_age_years, :null => false, :default => 0
      t.string :country_alpha2, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
