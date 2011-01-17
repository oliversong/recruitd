class Term < ActiveRecord::Base
  has_many :term_descriptions #, :order => "position"
  has_many :student_terms
  has_many :students, :through => :student_terms
  belongs_to :category
  belongs_to :entity, :polymorphic => true
  
  class Interest < Term
    scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  end

  class Award < Term
    scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  end
  
end