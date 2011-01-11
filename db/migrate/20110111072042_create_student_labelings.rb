class CreateStudentLabelings < ActiveRecord::Migration
  def self.up
    create_table :student_labelings do |t|
      t.integer :student_id
      t.integer :label_id
      t.integer :company_id
      t.integer :job_id

      t.timestamps
    end
  end

  def self.down
    drop_table :student_labelings
  end
end
