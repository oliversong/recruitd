class AddGenderToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :gender_is_male, :boolean
    add_column :people, :ethnicity_id, :integer
    remove_column :students, :gender_is_male
  end

  def self.down
    add_column :students, :gender_is_male, :boolean
    remove_column :people, :ethnicity_id
    remove_column :people, :gender_is_male
  end
end
