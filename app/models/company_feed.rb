class CompanyFeed < ActiveRecord::Base
  belongs_to :company
  belongs_to :student
  
  scope :showable, where(:dismissed => false, :deleted => false)
  
end
