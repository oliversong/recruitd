class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :type
      
      t.string :name
      t.string :location
      t.integer :category_id
      t.text :description
      t.string :url
      
      t.integer :added_by_user_id
      
      ## course stuff
      t.string :course_abbrev
      t.integer :course_difficulty_sum_cache, :null => false, :default => 0
      t.integer :course_difficulty_count_cache, :null => false, :default => 0
      t.integer :course_usefulness_sum_cache, :null => false, :default => 0
      t.integer :course_usefulness_count_cache, :null => false, :default => 0
      
      ## course and department stuff
      t.integer :department_id
      t.integer :school_id
      
      t.timestamps
      
      #attributes for type = Career
      #attributes for type = Course
      #attributes for type = Club
      #attributes for type = Interest
      #attributes for type = Award
    end
    
  end

  def self.down
    drop_table :terms
  end
end
