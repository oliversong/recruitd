class AddGenderToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gender_is_male, :boolean
    add_column :users, :ethnicity_id, :integer
    remove_column :students, :gender_is_male
    
    add_column :users, :entity_type, :string
    add_column :users, :entity_id, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def self.down
    add_column :students, :gender_is_male, :boolean
    remove_column :users, :ethnicity_id
    remove_column :users, :gender_is_male
    
    remove_column :users, :entity_type
    remove_column :users, :entity_id
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
