class StudentFeed < ActiveRecord::Base
  belongs_to :student
  belongs_to :company
  belongs_to :job
  
  scope :showable, where(:dismissed => false, :deleted => false)
    
end
