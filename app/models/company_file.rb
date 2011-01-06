class CompanyFile < ActiveRecord::Base
  belongs_to :company
  belongs_to :student
end
