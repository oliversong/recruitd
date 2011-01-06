class CourseStudent < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  belongs_to :period
end
