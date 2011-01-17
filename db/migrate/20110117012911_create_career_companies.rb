class CreateCareerCompanies < ActiveRecord::Migration
  def self.up
    create_table :career_companies do |t|
      t.integer :career_id
      t.integer :company_id
      t.integer :weight, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :career_companies
  end
end
