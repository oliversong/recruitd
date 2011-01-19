class CareerCompany < ActiveRecord::Base
  belongs_to :career
  belongs_to :company
end
