module ApplicationHelper
  
  def address_block(addressable)
    return_str = addressable.address_line1 + ", "
    if(!addressable.address_line2.blank?)
      return_str += addressable.address_line2 + ", "
    end
    return_str += addressable.address_city + ", " + addressable.address_state + "  " + addressable.address_zip
    return_str
  end
  
  def print_update_block(update, hash)
    if hash[:show_name]
      return_str = "#{update.person.full_name} wrote at #{update.updated_at.to_s}"
    else
      return_str = "At #{update.updated_at.to_s}"
    end
    
    return_str += content_tag(:br) + h(update.text)
    return_str
  end
  
  def link_to_external_profile(person)
    if person.student
      return link_to person.student.name, person.student
    elsif person.recruiter
      return link_to person.recruiter.name, person.recruiter
    end
  end
  
  def print_student_block(student, hash)
    return_str = link_to(student.name, student)
    return_str
  end
  

  
end
