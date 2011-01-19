class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table "roles" do |t|
      t.string :name
    end
    
    # generate the join table
    create_table "users_roles", :id => false do |t|
      t.integer "role_id", "user_id"
    end
    add_index "users_roles", "role_id"
    add_index "users_roles", "user_id"
  end

  def self.down
    drop_table "roles"
    drop_table "users_roles"
  end
end