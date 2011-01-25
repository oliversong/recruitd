class AddToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_summary, :text
    add_column :users, :about_me, :text
  end

  def self.down
    remove_column :users, :about_me
    remove_column :users, :profile_summary
  end
end
