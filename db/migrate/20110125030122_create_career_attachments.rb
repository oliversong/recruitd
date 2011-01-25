class CreateCareerAttachments < ActiveRecord::Migration
  def self.up
    create_table :career_attachments do |t|
      t.integer :career_id
      t.integer :attachable_id
      t.string :attachable_type
      t.integer :weight

      t.timestamps
    end
    
    add_index :career_attachments, :career_id
    add_index :career_attachments, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :career_attachments
  end
end
