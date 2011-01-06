require_dependency 'term'

class Experience < ActiveRecord::Base
  belongs_to :student
  
end

class WorkExperience < Experience
  belongs_to :company
  
  def company_line
    company.name + ", " + location
  end
end

class ClubExperience < Experience
  belongs_to :club
  
  def club_line
    club.name + ", " + location
  end
end