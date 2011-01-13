class AddFieldsToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :description, :text
    add_column :companies, :founded, :string
    add_column :companies, :website, :string
    add_column :companies, :size_category, :integer
  end

  def self.down
    remove_column :companies, :size_category
    remove_column :companies, :website
    remove_column :companies, :founded
    remove_column :companies, :description
  end
end
