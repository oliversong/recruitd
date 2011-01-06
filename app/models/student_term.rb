class StudentTerm < ActiveRecord::Base
  set_table_name 'student_term'
  belongs_to :student
  belongs_to :term
  
  class StudentInterest < StudentTerm
    belongs_to :interest
  end
  
  class StudentAward < StudentTerm
    belongs_to :award
  end
  
end
