class AddOwnershipCategoryToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :ownership_category, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :companies, :ownership_category
  end
end
