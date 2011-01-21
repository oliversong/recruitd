class CreateCompanyLabelings < ActiveRecord::Migration
  def self.up
    create_table :company_labelings do |t|
      t.integer :company_id
      t.integer :label_id
      t.integer :student_id

      t.timestamps
    end
    
    add_index :company_labelings, :company_id
    add_index :company_labelings, [:company_id, :label_id]
  end

  def self.down
    drop_table :company_labelings
  end
end
