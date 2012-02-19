class AllowVideoIdToBeNull < ActiveRecord::Migration
  def self.up
    change_column :quizzes, :video_id, :string, :null => true
  end

  def self.down
    change_column :quizzes, :video_id, :string, :null => false
  end
end
