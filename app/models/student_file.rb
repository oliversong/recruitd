class StudentFile < ActiveRecord::Base
  belongs_to :student
  belongs_to :company
  belongs_to :job
  
  RATINGS = [1,2,3,4,5]
  
  scope :for_company, :conditions => "company_id IS NOT NULL"
  scope :for_job, :conditions => "job_id IS NOT NULL"
  
  # class StudentFileCompany < StudentFile
  # end
  # 
  # class StudentFileJob < StudentFile
  # end
  
end