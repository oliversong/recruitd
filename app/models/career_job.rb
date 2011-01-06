class CareerJob < ActiveRecord::Base
  belongs_to :career
  belongs_to :job
end
