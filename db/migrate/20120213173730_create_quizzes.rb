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
