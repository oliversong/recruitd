class AddForeignKeysToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :user_id, :integer
    add_column :students, :address_id, :integer
  end

  def self.down
    remove_column :students, :user_id
    remove_column :students, :address_id
  end
end
