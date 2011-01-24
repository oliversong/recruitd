class Term < ActiveRecord::Base
  has_many :term_descriptions #, :order => "position"
  has_many :student_terms
  has_many :students, :through => :student_terms
  # belongs_to :reference, :polymorphic => true
  belongs_to :category
  
  acts_as_commentable
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  scope :of_type, lambda { |type| {:conditions => ["type = ?", type]} }
  
end