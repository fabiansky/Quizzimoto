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