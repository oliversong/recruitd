class CompanyLabeling < ActiveRecord::Base
  belongs_to :student
  belongs_to :company
  belongs_to :label
end
