class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.string :season
      t.integer :year
      t.integer :school_id

      t.timestamps
    end
  end

  def self.down
    drop_table :periods
  end
end
