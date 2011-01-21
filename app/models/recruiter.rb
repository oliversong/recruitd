class Recruiter < ActiveRecord::Base
  #belongs_to :user
  has_one :user, :as => :entity
  
  belongs_to :company
  
  def name
    return user.name
  end
  
end
