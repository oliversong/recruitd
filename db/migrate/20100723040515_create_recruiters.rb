class CreateRecruiters < ActiveRecord::Migration
  def self.up
    create_table :recruiters do |t|
      t.integer :phone
      t.integer :company_id
      t.integer :person_id
      
      t.string :address_line1
      t.string :address_line2
      t.string :address_city
      t.string :address_state
      t.string :address_zip

      t.timestamps
    end
  end

  def self.down
    drop_table :recruiters
  end
end


def self.up
  
  
  
end