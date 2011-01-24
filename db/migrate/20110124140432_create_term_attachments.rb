class CreateTermAttachments < ActiveRecord::Migration
  def self.up
    create_table :term_attachments do |t|
      t.integer :term_id
      t.integer :attachable_id
      t.string :attachable_type
      t.integer :weight, :null => false, :default => 0

      t.timestamps
    end
    
    add_index :term_attachments, :term_id
    add_index :term_attachments, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :term_attachments
  end
end
