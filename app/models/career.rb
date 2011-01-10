class Career < ActiveRecord::Base
  belongs_to :term
  has_many :career_jobs
  has_many :jobs, :through => :career_jobs
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
end
