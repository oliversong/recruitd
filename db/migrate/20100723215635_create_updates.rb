class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :person_id
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
