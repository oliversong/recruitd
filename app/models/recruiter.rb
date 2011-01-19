class Recruiter < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  after_create :create_user
  
  def name
    return user.name
  end
  
  def create_user
    if !user_id
      u = User.new(:first_name => "", :last_name => name)
      u.entity = self
      u.save
      self.user = u
    end
  end
  
end
