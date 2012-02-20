class AddFormIdToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :form_id, :string
  end

  def self.down
    remove_column :quizzes, :form_id
  end
end
