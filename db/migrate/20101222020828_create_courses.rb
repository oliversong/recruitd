class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.string :abbrev
      t.integer :department_id
      t.string :description
      t.integer :term_id
      t.integer :difficulty_sum_cache
      t.integer :difficulty_count_cache
      t.integer :usefulness_sum_cache
      t.integer :usefulness_count_cache

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
