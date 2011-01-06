class CompanyTerm < ActiveRecord::Base
  belongs_to :company
  belongs_to :term
end
