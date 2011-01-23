class CompanyFile < ActiveRecord::Base
  RATINGS = [1,2,3,4,5]
  
  belongs_to :company
  belongs_to :student
  
  default_scope order('feed_score DESC')
  
  scope :showable, where(:dismissed => false)
  scope :by_company_id, lambda{|company_id| where(:company_id => company_id, :dismissed => false) }
  
end
