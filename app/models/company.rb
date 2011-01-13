class Company < ActiveRecord::Base
  SIZE_CATEGORIES = [ "1-10 employees",
                      "11-50 employees",
                      "51-200 employees",
                      "201-500 employees",
                      "501-1000 employees",
                      "1001-5000 employees",
                      "5001-10000 employees",
                      "10001+ employees"]

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
  
  def size_category_text
    if size_category
      return SIZE_CATEGORIES[size_category]
    else
      return nil
    end
      
  end
end
