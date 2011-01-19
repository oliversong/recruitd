class CreateCompanyFiles < ActiveRecord::Migration
  def self.up
    create_table :company_files do |t|
      t.integer :company_id
      t.integer :student_id
      t.integer :rating
      t.text :notes
      t.boolean :starred, :null => false, :default => false
      t.boolean :dismissed, :null => false, :default => false
      t.integer :vote, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :company_files
  end
end
