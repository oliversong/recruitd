class Company < ActiveRecord::Base
  belongs_to :user
  has_many :jobs
  has_many :recruiters
  has_many :company_files
  has_many :company_feeds, :order => "score DESC"
  has_many :company_terms, :include => ["term"]
  
  named_scope :limit, lambda { |limit| {:limit => limit} }
  
  named_scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
end
