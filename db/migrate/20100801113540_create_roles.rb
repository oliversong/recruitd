class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table "roles" do |t|
      t.string :name
    end
    
    # generate the join table
    create_table "people_roles", :id => false do |t|
      t.integer "role_id", "person_id"
    end
    add_index "people_roles", "role_id"
    add_index "people_roles", "person_id"
  end

  def self.down
    drop_table "roles"
    drop_table "people_roles"
  end
end