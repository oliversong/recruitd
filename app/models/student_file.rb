class StudentFile < ActiveRecord::Base
  belongs_to :student
end

class StudentFileCompany < StudentFile
   belongs_to :company
 end

 class StudentFileJob < StudentFile
   belongs_to :job
 end
