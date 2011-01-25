class Career < ActiveRecord::Base
  # has_one :term, :as => :reference
  
  has_many :career_attachments
  has_many :attachables, :through => :career_attachments
  
  has_many :term_attachments, :as => :attachable
  has_many :terms, :through => :term_attachments
  
  has_many :career_students
  has_many :students, :through => :career_students
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  acts_as_commentable
  
  # after_create :create_term
  # 
  # def create_term
  #   Term.new(:name => name, :reference => self).save
  # end
  # 
end
