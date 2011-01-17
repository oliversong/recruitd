class CreateCareerTerms < ActiveRecord::Migration
  def self.up
    create_table :career_terms do |t|
      t.integer :career_id
      t.integer :term_id
      t.integer :weight, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :career_terms
  end
end
