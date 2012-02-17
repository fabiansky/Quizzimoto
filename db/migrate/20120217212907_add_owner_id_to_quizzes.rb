class AddOwnerIdToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :owner_id, :string
  end

  def self.down
    remove_column :quizzes, :owner_id
  end
end
