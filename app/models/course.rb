class Course < ActiveRecord::Base
  belongs_to :department
  
  has_one :term, :as => :reference
  
  has_many :course_students
  has_many :students, :through => :course_students
  has_many :course_ratings
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  after_create :create_term
  
  def create_term
    Term.new(:name => name, :reference => self).save
  end
  
  def display_usefulness
    if usefulness_count_cache && (usefulness_count_cache > 0)
      ret = (usefulness_sum_cache*1.0 / usefulness_count_cache).round(2)
    else
      ret = "no ratings"
    end
    ret
  end
  
  def display_difficulty
    if difficulty_count_cache && (difficulty_count_cache > 0)
      ret = (difficulty_sum_cache*1.0/difficulty_count_cache).round(2)
    else
      ret = "no ratings"
    end
    ret
  end
  
end
