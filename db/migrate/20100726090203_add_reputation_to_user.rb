class AddReputationToUser < ActiveRecord::Migration
  def self.up
    add_column :people, :rep_alltime, :integer
    add_column :people, :rep_month, :integer
  end

  def self.down
    remove_column :people, :rep_month
    remove_column :people, :rep_alltime
  end
end
