class AddFieldsToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :location, :string
    add_column :students, :languages, :string
  end

  def self.down
    remove_column :students, :languages
    remove_column :students, :location
  end
end
