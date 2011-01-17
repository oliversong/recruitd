class AddReferenceToTerm < ActiveRecord::Migration
  def self.up
    add_column :terms, :reference_id, :integer
    add_column :terms, :reference_type, :string
  end

  def self.down
    remove_column :terms, :reference_type
    remove_column :terms, :reference_id
  end
end
