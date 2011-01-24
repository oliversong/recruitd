class TermAttachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  belongs_to :term
end
