class AddBaselineScoreToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :baseline_score, :integer, :null => false, :default => 0
    add_column :career_students, :score, :integer, :null => false, :default => 0
    add_column :student_term, :score, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :student_term, :score
    remove_column :career_students, :score
    remove_column :students, :baseline_score
  end
end