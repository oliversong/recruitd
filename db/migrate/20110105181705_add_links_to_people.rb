class AddLinksToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :entity_type, :string
    add_column :people, :entity_id, :integer
  end

  def self.down
    remove_column :peoples, :entity_type
    remove_column :peoples, :entity_id

  end
end
