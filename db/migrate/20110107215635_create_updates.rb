class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :user_id
      t.text :text

      t.timestamps
    end
    
    add_index :updates, :user_id
  end

  def self.down
    drop_table :updates
  end
end
