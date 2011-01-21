class CreateCourseStudents < ActiveRecord::Migration
  def self.up
    create_table :course_students do |t|
      t.integer :student_id
      t.integer :course_id
      t.integer :period_id
      t.text :comments

      t.timestamps
    end
    
    add_index :course_students, :student_id
    add_index :course_students, :course_id
  end

  def self.down
    drop_table :course_students
  end
end
