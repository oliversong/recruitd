class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :type
      
      t.string :name
      t.string :location
      t.integer :category_id
      t.text :description
      t.string :url
      
      t.integer :reference_id
      t.string :reference_type
      
      
      t.timestamps
      
      #attributes for type = Career
      #attributes for type = Course
      #attributes for type = Club
      #attributes for type = Interest
      #attributes for type = Award
    end
    
    add_index :terms, [:reference_id, :reference_type]
    
  end

  def self.down
    drop_table :terms
  end
end