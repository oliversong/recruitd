class CreateCompanyFeeds < ActiveRecord::Migration
  def self.up
    create_table :company_feeds do |t|
      t.integer :company_id
      t.integer :student_id
      t.integer :score
      t.datetime :last_seen
      t.datetime :dismissed_until
      t.boolean :dismissed, :default => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :company_feeds
  end
end
