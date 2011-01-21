class CreateCourseRatings < ActiveRecord::Migration
  def self.up
    create_table :course_ratings do |t|
      t.integer :student_id
      t.integer :course_id
      t.integer :difficulty
      t.integer :usefulness

      t.timestamps
    end
    
    add_index :course_ratings, :course_id
  end

  def self.down
    drop_table :course_ratings
  end
end
