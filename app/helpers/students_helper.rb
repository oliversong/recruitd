module StudentsHelper
  def school_block_for_student(ss)
    return_str = link_to(ss.school.name, ss.school) + ", " + h(ss.school.location)
    if ss.degree_name != nil and ss.department != nil
      return_str += content_tag(:br)
      if !ss.completed
        return_str += "Candidate for "
      end
      return_str += h(ss.degree_name + ", " + ss.department.name)
    end
    
    if ss.gpa != nil
      return_str += content_tag(:br) + "GPA: " + ss.gpa.to_s
    end
    
    if ss.details != nil
      return_str += content_tag(:br) + h(ss.details)
    end
    
    return_str
  end
  
  def work_experience_block(experience)
    return_str = link_to( experience.company.name, experience.company) + ", " + h(experience.location) + content_tag(:br)
    return_str += h(experience.job_title) + content_tag(:br)
    return_str += experience.description
    return_str
  end
  
  def club_experience_block(experience)
    return_str = link_to( experience.club.name, experience.club) + content_tag(:br)
    return_str += h(experience.job_title) + content_tag(:br)
    return_str += h(experience.description)
    return_str
  end
  
  def career_block(career)
    return_str = link_to(career.name, career)
    return_str
  end
  
  def interest_block(interest)
    return_str = link_to(interest.name, interest.becomes(Term))
    return_str
  end
  
end
