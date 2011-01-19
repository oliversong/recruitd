class CreateStudentTerm < ActiveRecord::Migration
  def self.up
    create_table :student_term do |t|
      t.string :details
      t.integer :student_id
      t.integer :term_id
      t.string :term_type

      t.timestamps
    end
  end

  def self.down
    drop_table :student_terms
  end
end
