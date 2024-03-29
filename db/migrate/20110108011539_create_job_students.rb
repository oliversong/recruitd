class CreateJobStudents < ActiveRecord::Migration
  def self.up
    create_table :job_students do |t|
      t.integer :job_id
      t.integer :student_id
      t.boolean :applied
      #t.boolean :student_follows_job
      #t.integer :job_score
      #t.datetime :job_dismissed_until

      t.timestamps
    end
    
    add_index :job_students, :student_id
    add_index :job_students, :job_id
  end

  def self.down
    drop_table :job_students
  end
end
