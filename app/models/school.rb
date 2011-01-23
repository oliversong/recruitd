class School < ActiveRecord::Base
  has_one :term, :as => :reference
  
  def location
    return "#{address_city}, #{address_state}"
  end
end
