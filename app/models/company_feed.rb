class CompanyFeed < ActiveRecord::Base
  belongs_to :company
  belongs_to :student
  
  default_scope order('score DESC')
  
  scope :showable, where(:dismissed => false, :deleted => false)
  scope :by_company_id, lambda{|company_id| where(:company_id => company_id, :deleted => false, :dismissed => false) }
end
