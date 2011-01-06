class CreateStudentFiles < ActiveRecord::Migration
  def self.up
    create_table :student_files do |t|
      t.integer :student_id
      t.integer :company_id
      t.integer :job_id
      t.integer :rating
      t.text :notes
      t.boolean :starred
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :student_files
  end
end
