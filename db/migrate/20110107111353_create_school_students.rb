class CreateSchoolStudents < ActiveRecord::Migration
  def self.up
    create_table :school_student, :id => false do |t|
      t.integer :school_id
      t.integer :student_id
      t.date :startdate
      t.date :enddate
      t.text :details
      t.text :degree_name
      t.integer :department_id
      t.float :gpa
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :school_student
  end
end
