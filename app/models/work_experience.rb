class WorkExperience < Experience
  belongs_to :company
  
  def company_line
    company.name + ", " + location
  end
end
