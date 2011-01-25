class TermAttachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  belongs_to :term
  
  belongs_to :career, :class_name => "Career", :foreign_key => "attachable_id"
  belongs_to :job, :class_name => "Job", :foreign_key => "attachable_id"
  
  def attachable_type=(sType)
     super(sType.to_s.classify.constantize.base_class.to_s)
  end
  
end
