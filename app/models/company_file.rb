class CompanyFile < ActiveRecord::Base
  RATINGS = [1,2,3,4,5]
  
  belongs_to :company
  belongs_to :student
end
