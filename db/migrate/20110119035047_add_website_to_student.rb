class AddWebsiteToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :website, :string
    add_column :recruiters, :website, :string
  end

  def self.down
    remove_column :recruiters, :website
    remove_column :students, :website
  end
end
