class Term < ActiveRecord::Base
  has_many :term_descriptions #, :order => "position"
  has_many :student_terms
  has_many :students, :through => :student_terms
  belongs_to :category
  belongs_to :entity, :polymorphic => true
  
  class Interest < Term
  end

  class Award < Term
  end
  
end