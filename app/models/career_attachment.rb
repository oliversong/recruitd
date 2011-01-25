class CareerAttachment < ActiveRecord::Base
  belongs_to :career
  belongs_to :attachable, :polymorphic => true
  
  belongs_to :company,  :class_name => "Company",
                          :foreign_key => "attachable_id"
  belongs_to :job,  :class_name => "Job",
                          :foreign_key => "attachable_id"
  belongs_to :student,  :class_name => "Student",
                          :foreign_key => "attachable_id"
                          
  def attachable_type=(sType)
     super(sType.to_s.classify.constantize.base_class.to_s)
  end

end
