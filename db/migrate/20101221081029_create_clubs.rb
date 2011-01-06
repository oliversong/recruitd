class CreateClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.integer :term_id
      t.string :name
      t.text :description
      t.integer :added_by_person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clubs
  end
end
