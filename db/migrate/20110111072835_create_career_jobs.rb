class CreateCareerJobs < ActiveRecord::Migration
  def self.up
    create_table :career_jobs do |t|
      t.integer :career_id
      t.integer :job_id

      t.timestamps
    end
    
    add_index :career_jobs, :job_id
    add_index :career_jobs, :career_id
  end

  def self.down
    drop_table :career_jobs
  end
end
