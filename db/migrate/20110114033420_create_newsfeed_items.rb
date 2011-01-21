class CreateNewsfeedItems < ActiveRecord::Migration
  def self.up
    create_table :newsfeed_items do |t|
      t.text :text
      t.string :type
      t.integer :reference_id
      t.string :reference_type
      t.integer :user_id
      t.integer :entity_id
      t.string :entity_type
      t.datetime :update_time

      t.timestamps
    end
    
    add_index :newsfeed_items, :user_id
  end

  def self.down
    drop_table :newsfeed_items
  end
end
