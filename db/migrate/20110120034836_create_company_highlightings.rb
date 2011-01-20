class CreateCompanyHighlightings < ActiveRecord::Migration
  def self.up
    create_table :company_highlightings do |t|
      t.integer :company_id
      t.integer :student_id
      t.integer :reference_id
      t.string :reference_type

      t.timestamps
    end
  end

  def self.down
    drop_table :company_highlightings
  end
end
