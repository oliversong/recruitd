class CourseRating < ActiveRecord::Base
  RATINGS = [1,2,3,4,5]
  belongs_to :student
  belongs_to :course
  
  after_save :update_course_rating_cache
  
  def update_course_rating_cache
    if difficulty
      course.difficulty_sum_cache = course.difficulty_sum_cache ? course.difficulty_sum_cache + difficulty : difficulty
      course.difficulty_count_cache = course.difficulty_count_cache ? course.difficulty_count_cache + 1 : 1
    end
    
    if usefulness
      course.usefulness_sum_cache = course.usefulness_sum_cache ? course.usefulness_sum_cache + usefulness : usefulness
      course.usefulness_count_cache = course.usefulness_count_cache ? course.usefulness_count_cache + 1 : 1
    end
    course.save
  end
end
