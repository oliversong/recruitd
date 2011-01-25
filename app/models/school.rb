class School < ActiveRecord::Base
  # has_one :term, :as => :reference
  # 
  # after_create :create_term
  # 
  # def create_term
  #   Term.new(:name => name, :reference => self).save
  # end
  
  has_many :departments
  
  def location
    return "#{address_city}, #{address_state}"
  end
end
