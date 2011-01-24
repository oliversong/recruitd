class AddStudentsAndRecruitersToUser < ActiveRecord::Migration
  def self.up
    
    #inheritance
    add_column :users, :type, :string
    
    #students
    add_column :users, :gpa, :float
    add_column :users, :hometown, :string
    add_column :users, :subtitle, :text
    add_column :users, :phone, :integer
    add_column :users, :gender_is_male, :boolean
    add_column :users, :ethnicity, :string
    add_column :users, :highlights, :text
    add_column :users, :fun_facts, :text
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string
    add_column :users, :address_zip, :string 
    add_column :users, :location, :string
    add_column :users, :languages, :string
    add_column :users, :baseline_score, :integer, :null => false, :default => 0
    
    #recruiters
    add_column :users, :company_id, :integer
    
    #all
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean, :null => false, :default => false
    add_column :users, :website, :string
    
    #permalinking
    add_column :users, :username, :string
    
    add_index :users, :username
    
  end

  def self.down
    remove_column :users, :baseline_score    
    remove_column :users, :languages
    remove_column :users, :location
  end
end
