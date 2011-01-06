class CreateTermDescriptions < ActiveRecord::Migration
  def self.up
    create_table :term_descriptions do |t|
      t.integer :person_id
      t.integer :term_id
      t.integer :update_of_term_description_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :term_descriptions
  end
end
