class Recruiter < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  
  def name
    return user.name
  end
end
