class AddVoteToCompanyFile < ActiveRecord::Migration
  def self.up
    add_column :company_files, :vote, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :company_files, :vote
  end
end
