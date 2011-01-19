class AddTermTypeToStudentTerm < ActiveRecord::Migration
  def self.up
    add_column :student_term, :term_type, :string
    remove_column :student_term, :type
  end

  def self.down
    add_column :student_term, :type, :string
    remove_column :student_term, :term_type
  end
end
