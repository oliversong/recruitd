class AddReputationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :rep_alltime, :integer
    add_column :users, :rep_month, :integer
  end

  def self.down
    remove_column :users, :rep_month
    remove_column :users, :rep_alltime
  end
end
