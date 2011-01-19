class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.integer :student_id
      t.date :startdate
      t.date :enddate
      t.string :job_title
      t.text :description
      t.string :location
      t.string :type
      
      
      ###fields just for WorkExperiences
      t.integer :company_id
      
      ###fields just for SchoolExperiences
      t.integer :club_id
      

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
