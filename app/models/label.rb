class Label < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_many :student_labelings
  has_many :company_labelings
  
  # def attachable_type=(sType)
  #    super(sType.to_s.classify.constantize.base_class.to_s)
  # end
end
