class StudentLabeling < ActiveRecord::Base
  belongs_to :student
  belongs_to :label
  
  #one of these
  belongs_to :company
  belongs_to :job
  
  #scope :by_student, lambda { |student| :where(:student => student) }
end
