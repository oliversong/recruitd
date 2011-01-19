class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :text
      t.integer :reference_id
      t.integer :reference_type
      t.boolean :is_reused
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end