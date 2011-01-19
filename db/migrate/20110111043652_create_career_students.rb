class CreateCareerStudents < ActiveRecord::Migration
  def self.up
    create_table :career_students do |t|
      t.integer :career_id
      t.integer :student_id

      t.timestamps
    end
  end

  def self.down
    drop_table :career_students
  end
end
