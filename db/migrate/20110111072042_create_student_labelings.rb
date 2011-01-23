class CreateStudentLabelings < ActiveRecord::Migration
  def self.up
    create_table :student_labelings do |t|
      t.integer :student_id
      t.integer :label_id
      
      t.integer :applyable_id
      t.integer :applyable_term
      t.integer :student_file_id

      t.timestamps
    end
    
    add_index :student_labelings, :student_id
    add_index :student_labelings, [:student_id, :label_id]
    add_index :student_labelings, :student_file_id
  end

  def self.down
    drop_table :student_labelings
  end
end
