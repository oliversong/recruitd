class AddPositionToTermDescription < ActiveRecord::Migration
  def self.up
    add_column :term_descriptions, :position, :integer
  end

  def self.down
    remove_column :term_descriptions, :position
  end
end
