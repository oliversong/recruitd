class CreateStudentFeeds < ActiveRecord::Migration
  def self.up
    create_table :student_feeds do |t|
      t.integer :student_id
      t.integer :company_id
      t.integer :job_id
      t.integer :score
      t.datetime :last_seen
      t.datetime :dismissed_until
      t.boolean :dismissed, :default => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
    
    add_index :student_feeds, [:student_id, :company_id]
    add_index :student_feeds, [:student_id, :job_id]
  end

  def self.down
    drop_table :student_feeds
  end
end
