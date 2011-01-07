class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :address_city
      t.string :address_state
      t.string :address_zip
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
