class ProcessFeedbackJob < Struct.new(:actor_type, :actor_id, :subject_type, :subject_id, :action)
  #tentatively, some point values
  UP = 0
  DOWN = 1
  STAR = 2
  UNSTAR = 3
  
  POINTS = {UP => 1, DOWN => -1, STAR => 2, UNSTAR => -2}
  
  def perform
    if actor_type == "Company" && subject_type == "Student"
      perform_company_on_student
    elsif actor_type == "Student"
      if subject_type == "Company"
        perform_student_on_company
      elsif subject_type == "Job"
        perform_student_on_job
      end
    end
  end

  def perform_company_on_student
    if !POINTS.has_key?(action)
      puts "unknown action #{action}"
      return
    end
    
    #update baseline for student
    student = Student.find(subject_id)
    student.baseline_score += POINTS[action]
    student.save
    
    puts "baseline score for #{student.name} was changed to #{student.baseline_score}"
    
    #update career-specific weights for student
    
    #update tag weights for company
  end
  
  def perform_student_on_company
  end
  
  def perform_student_on_job
  end
  
  
end