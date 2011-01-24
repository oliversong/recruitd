class Career < ActiveRecord::Base
  has_one :term, :as => :reference
  
  has_many :career_jobs
  has_many :jobs, :through => :career_jobs
  
  has_many :career_terms
  has_many :relevant_terms, :class_name => "Term", :source => :term, :through => :career_terms
  
  has_many :career_students
  has_many :students, :through => :career_students
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  after_create :create_term
  
  def create_term
    Term.new(:name => name, :reference => self).save
  end
  
end
