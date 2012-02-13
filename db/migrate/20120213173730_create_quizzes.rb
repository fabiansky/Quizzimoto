class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.string :name
      t.string :playlist_id
      t.integer :min_age_years
      t.string :country_alpha2

      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
