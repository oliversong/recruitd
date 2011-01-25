class CareerAttachment < ActiveRecord::Base
  belongs_to :career
  belongs_to :attachable, :polymorphic => true
end
