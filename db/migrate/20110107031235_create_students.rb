class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.float :gpa
      t.string :hometown
      t.text :subtitle
      t.integer :phone
      t.boolean :gender_is_male
      t.text :highlights
      t.text :fun_facts
      t.string :address_line1
      t.string :address_line2
      t.string :address_city
      t.string :address_state
      t.string :address_zip
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
