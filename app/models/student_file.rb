class StudentFile < ActiveRecord::Base
  belongs_to :student
  
  RATINGS = [1,2,3,4,5]
  
  class StudentFileCompany < StudentFile
    belongs_to :company
  end

  class StudentFileJob < StudentFile
    belongs_to :job
  end
  
end


