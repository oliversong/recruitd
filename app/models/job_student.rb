class JobStudent < ActiveRecord::Base
  belongs_to :job
  belongs_to :student
end
