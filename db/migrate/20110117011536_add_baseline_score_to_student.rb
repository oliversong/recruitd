class AddBaselineScoreToStudent < ActiveRecord::Migration
  def self.up
    add_column :career_students, :score, :integer, :null => false, :default => 0
    add_column :student_terms, :score, :integer, :null => false, :default => 0
    
  end

  def self.down
    remove_column :student_terms, :score
    remove_column :career_students, :score
  end
end