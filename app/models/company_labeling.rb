class CompanyLabeling < ActiveRecord::Base
  belongs_to :company
  
  belongs_to :student
  belongs_to :label
  
  belongs_to :company_file
  
  after_create :create_company_file
  
  def create_company_file
    if !company_file_id
      cf = CompanyFile.find_or_create_by_company_id_and_student_id(company_id, student_id)
      self.company_file_id = cf.id
      self.save
    end
  end
end
