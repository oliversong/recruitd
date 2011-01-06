class CareerStudent < ActiveRecord::Base
  belongs_to :career
  belongs_to :student
end
