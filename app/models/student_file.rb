class StudentFile < ActiveRecord::Base
  belongs_to :student
  belongs_to :applyable, :polymorphic => true
  
  RATINGS = [1,2,3,4,5]
  
  default_scope order('feed_score DESC')
  
  scope :showable, where(:dismissed => false)
  scope :by_student_id, lambda{|student_id| where(:student_id => student_id, :dismissed => false) }
  
end