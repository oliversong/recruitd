class Job < ActiveRecord::Base
  belongs_to :company
  has_many :career_jobs
  has_many :careers, :through => :career_jobs
  has_many :student_labelings, :as => :applyable
  
  has_many :term_attachments, :as => :attachable
  has_many :terms, :through => :term_attachments
  
  def name
    return title + " at " + company.name
  end
  
  def owned_by?(r)
    return company_id == r.company_id
  end
end
