class Term < ActiveRecord::Base
  has_many :term_descriptions #, :order => "position"
  has_many :student_terms
  has_many :students, :through => :student_terms
  # belongs_to :reference, :polymorphic => true
  belongs_to :category
  
  has_many :term_attachments
  # has_many :companies, :through => :company_terms, :source => :company, :conditions => "term_attachments.attachable_type = 'Company'"
  
  has_many :jobs, :through => :term_attachments, :source => :job, :conditions => "term_attachments.attachable_type = 'Job'" 
  
  has_many :careers, :through => :term_attachments, :source => :career, :conditions => "term_attachments.attachable_type = 'Career'"
  
  
  
  acts_as_commentable
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  scope :of_type, lambda { |type| {:conditions => ["type = ?", type]} }
  
end