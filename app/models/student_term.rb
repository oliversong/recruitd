class StudentTerm < ActiveRecord::Base
  set_table_name 'student_term'
  belongs_to :student
  belongs_to :term
  
  scope :only_awards, :conditions => ["term_type = ?", "Award"]
  scope :only_interests, :conditions => ["term_type = ?", "Interest"]
    
end