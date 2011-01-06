class School < ActiveRecord::Base
  belongs_to :term
  
  def location
    return "#{address_city}, #{address_state}"
  end
end
