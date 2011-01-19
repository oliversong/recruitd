class CreateUserTasks < ActiveRecord::Migration
  def self.up
    create_table :user_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :task_type
      t.integer :reference_id

      t.timestamps
    end
  end

  def self.down
    drop_table :task_users
  end
end
