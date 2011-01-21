class CreateStudentFiles < ActiveRecord::Migration
  def self.up
    create_table :student_files do |t|
      t.integer :student_id
      t.integer :company_id
      t.integer :job_id
      t.integer :rating
      t.text :notes
      t.boolean :starred, :null => false, :default => false
      t.boolean :dismissed, :null => false, :default => false
      t.integer :vote, :null => false, :default => 0
      
      t.timestamps
    end
    
    add_index :student_files, [:student_id, :company_id]
    add_index :student_files, [:student_id, :job_id]
  end

  def self.down
    drop_table :student_files
  end
end
