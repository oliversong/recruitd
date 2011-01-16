class AddVoteToStudentFile < ActiveRecord::Migration
  def self.up
    add_column :student_files, :vote, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :student_files, :vote
  end
end
