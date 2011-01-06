class CreateRepTransactions < ActiveRecord::Migration
  def self.up
    create_table :rep_transactions do |t|
      t.integer :person_id
      t.integer :rep_change
      t.integer :transaction_type
      t.integer :reference_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rep_transactions
  end
end
