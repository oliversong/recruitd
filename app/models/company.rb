class Company < ActiveRecord::Base
  belongs_to :user
  has_many :jobs
  has_many :recruiters
  has_many :company_files
  has_many :company_feeds, :order => "score DESC"
  has_many :company_terms, :include => ["term"]
  has_many :labels, :as => :owner
  has_many :student_labelings
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  
  def company
    return this
  end
  
  def company_id
    return id
  end
end
