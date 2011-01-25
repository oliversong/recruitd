module ApplicationHelper
  
  def address_block(addressable)
    return_str = ""
    if(!addressable.address_line1.blank?)
      return_str += addressable.address_line1 + ", "
    end
    
    if(!addressable.address_line2.blank?)
      return_str += addressable.address_line2 + ", "
    end
    
    if(!addressable.address_city.blank?)
      return_str += addressable.address_city + ", " 
    end
    
    if(!addressable.address_state.blank?)
      return_str += addressable.address_state + "  " 
    end
    
    if(!addressable.address_zip.blank?)
      return_str += addressable.address_zip
    end
    
    return_str
  end
  
  def print_update_block(update, hash)
    if hash[:show_name]
      return_str = "#{update.user.name} wrote at #{update.updated_at.to_s}"
    else
      return_str = "At #{update.updated_at.to_s}"
    end
    
    return_str +=   tag(:br) + h(update.text)
    return_str.html_safe
  end
  
  def link_to_external_profile(person)
    return link_to user.name, user.entity
  end
  
  def print_student_block(student, hash)
    return_str = link_to(student.name, student).html_safe
    return_str
  end
  
  def link_to_term(term)
    case term.class.name
    when "Course", "Club", "Department", "Term" then 
      return_str = link_to(term.name, term)
    when "Award", "Interest", "Skill" then
      return_str = link_to(term.name, term.becomes(Term))
    end
    return_str
  end
      

  
end
