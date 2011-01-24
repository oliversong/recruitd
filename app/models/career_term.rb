class CareerTerm < ActiveRecord::Base
  belongs_to :career
  belongs_to :term
end
