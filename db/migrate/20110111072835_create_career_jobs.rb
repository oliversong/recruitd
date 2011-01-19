class CreateCareerJobs < ActiveRecord::Migration
  def self.up
    create_table :career_jobs do |t|
      t.integer :career_id
      t.integer :job_id

      t.timestamps
    end
  end

  def self.down
    drop_table :career_jobs
  end
end
