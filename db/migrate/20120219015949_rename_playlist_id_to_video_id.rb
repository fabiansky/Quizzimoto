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

# A quiz should contain a video_id, not a playlist_id.  This simplifies the
# app quite a bit.  At this point, it's safe to assume there aren't any real
# playlist_ids in the database, so renaming the column is the simplest thing
# to do.
class RenamePlaylistIdToVideoId < ActiveRecord::Migration
  def self.up
    rename_column :quizzes, :playlist_id, :video_id
  end

  def self.down
    rename_column :quizzes, :video_id, :playlist_id
  end
end