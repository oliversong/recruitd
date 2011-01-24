class Course < Term
  belongs_to :department
  has_many :course_ratings
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  # after_create :create_term
  # 
  # def create_term
  #   Term.new(:name => name, :reference => self).save
  # end
  
  def display_usefulness
    if course_usefulness_count_cache && (course_usefulness_count_cache > 0)
      ret = (course_usefulness_sum_cache*1.0 / course_usefulness_count_cache).round(2)
    else
      ret = "no ratings"
    end
    ret
  end
  
  def display_difficulty
    if course_difficulty_count_cache && (course_difficulty_count_cache > 0)
      ret = (course_difficulty_sum_cache*1.0/course_difficulty_count_cache).round(2)
    else
      ret = "no ratings"
    end
    ret
  end
  
end
