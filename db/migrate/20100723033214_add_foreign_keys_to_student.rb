class AddForeignKeysToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :person_id, :integer
    add_column :students, :address_id, :integer
  end

  def self.down
    remove_column :students, :person_id
    remove_column :students, :address_id
  end
end
