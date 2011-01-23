class CreateStudentTerm < ActiveRecord::Migration
  def self.up
    create_table :student_term do |t|
      t.string :details
      t.integer :student_id
      t.integer :term_id
      t.string :term_type

      t.timestamps
    end
    
    add_index :student_term, :student_id
    add_index :student_term, [:student_id, :term_id]

  end

  def self.down
    drop_table :student_terms
  end
end