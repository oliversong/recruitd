require_dependency 'term'

class SchoolStudent < ActiveRecord::Base
  set_table_name 'school_student'
  belongs_to :school
  belongs_to :student
  belongs_to :department
  

end
