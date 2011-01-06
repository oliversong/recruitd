class CreateCareers < ActiveRecord::Migration
  def self.up
    create_table :careers do |t|
      t.string :name
      t.text :description
      t.integer :term_id

      t.timestamps
    end
  end

  def self.down
    drop_table :careers
  end
end
