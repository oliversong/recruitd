class Career < ActiveRecord::Base
  # has_one :term, :as => :reference
  
  has_many :career_attachments
  has_many :companies, :through => :career_attachments, :source => :company, :conditions => "career_attachments.attachable_type = 'Company'"
  has_many :jobs, :through => :career_attachments, :source => :job, :conditions => "career_attachments.attachable_type = 'Job'"
  has_many :students, :through => :career_attachments, :source => :student, :conditions => "career_attachments.attachable_type = 'Student'"
  
  has_many :term_attachments, :as => :attachable
  has_many :terms, :through => :term_attachments
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  acts_as_commentable
  
  # def terms
  #    return term_attachments.map{|ta| ta.term}
  #  end
  
  # after_create :create_term
  # 
  # def create_term
  #   Term.new(:name => name, :reference => self).save
  # end
  # 
end
