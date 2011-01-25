class TermAttachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  belongs_to :term
  
  belongs_to :career, :class_name => "Career", :foreign_key => "attachable_id"
  belongs_to :job, :class_name => "Job", :foreign_key => "attachable_id"
end
