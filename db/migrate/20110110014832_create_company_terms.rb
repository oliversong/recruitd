class CreateCompanyTerms < ActiveRecord::Migration
  def self.up
    create_table :company_terms do |t|
      t.integer :company_id
      t.integer :term_id
      t.integer :weight
      t.integer :last_updated_by_user_id
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :company_terms
  end
end
