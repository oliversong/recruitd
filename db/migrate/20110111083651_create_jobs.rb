class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :company_id
      t.string :title
      t.text :responsibilities
      t.text :basic_qualifications
      t.text :desired_qualifications
      t.text :other_information
      t.text :description

      t.timestamps
    end
    
    add_index :jobs, :company_id
  end

  def self.down
    drop_table :jobs
  end
end
