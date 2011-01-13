class AddEntityToTerm < ActiveRecord::Migration
  def self.up
    add_column :terms, :entity_id, :integer
    add_column :terms, :entity_type, :string
  end

  def self.down
    remove_column :terms, :entity_type
    remove_column :terms, :entity_id
  end
end
