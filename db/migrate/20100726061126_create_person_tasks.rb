class CreatePersonTasks < ActiveRecord::Migration
  def self.up
    create_table :person_tasks do |t|
      t.integer :person_id
      t.integer :task_id
      t.integer :task_type
      t.integer :reference_id

      t.timestamps
    end
  end

  def self.down
    drop_table :task_persons
  end
end
