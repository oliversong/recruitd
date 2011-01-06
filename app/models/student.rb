require_dependency 'experience'
require_dependency 'term'
require_dependency 'student_term'

class Student < ActiveRecord::Base
  belongs_to :person
  has_many :experiences
  
  has_many :work_experiences
  has_many :companies, :through => :work_experiences
   
  has_many :club_experiences
  has_many :clubs, :through => :club_experiences

  has_many :school_students
  has_many :schools, :through => :school_students
  
  has_many :course_students
  has_many :courses, :through => :course_students
  
  has_many :career_students
  has_many :careers, :through => :career_students
  
  has_many :student_terms
  has_many :terms, :through => :student_terms
  
  has_many :student_files
  has_many :student_feeds, :order => "score DESC"
  
  # has_many :student_awards, :class_name => "StudentTerm::StudentAward"
  # has_many :awards, :through => :student_awards
  # 
  # has_many :student_interests
  # has_many :interests, :through => :student_interests
  #
  # 
  # has_many :company_students
  # has_many :companies, :through => :company_students
  # 
  # has_many :job_students, :order => "job_score desc"
  # has_many :jobs, :through => :job_students
  
  def interests
    return terms.find_all_by_type('Interest')
  end
  
  def awards
    return terms.find_all_by_type('Award')
  end
  
  def name
    return person.name
  end
  
  
  
end
