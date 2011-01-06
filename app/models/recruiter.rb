class Recruiter < ActiveRecord::Base
  belongs_to :person
  belongs_to :company
  
  def name
    return person.name
  end
end
