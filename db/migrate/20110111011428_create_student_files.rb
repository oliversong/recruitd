class CreateStudentFiles < ActiveRecord::Migration
  def self.up
    create_table :student_files do |t|
      t.integer :student_id
      t.integer :applyable_id
      t.string :applyable_type
      t.integer :rating
      t.text :notes
      
      t.boolean :starred, :null => false, :default => false
      t.boolean :dismissed, :null => false, :default => false
      t.integer :vote, :null => false, :default => 0
      
      t.integer :feed_score
      t.datetime :feed_last_seen
      t.datetime :dismissed_until
      
      t.timestamps
    end
    
    add_index :student_files, [:student_id, :applyable_id, :applyable_type]
    add_index :student_files, :student_id
  end

  def self.down
    drop_table :student_files
  end
end
