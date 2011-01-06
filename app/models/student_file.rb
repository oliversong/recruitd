class StudentFile < ActiveRecord::Base
  belongs_to :student
  
  class StudentFileCompany < StudentFile
     belongs_to :company
   end

   class StudentFileJob < StudentFile
     belongs_to :job
   end
end
