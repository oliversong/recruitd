class Course < ActiveRecord::Base
  belongs_to :department
  belongs_to :term
  has_many :course_students
  has_many :students, :through => :course_students
  
  named_scope :limit, lambda { |limit| {:limit => limit} }
  
  named_scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
end
