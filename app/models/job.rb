class Job < ActiveRecord::Base
  belongs_to :company

  has_many :student_labelings, :as => :applyable
  
  has_many :term_attachments, :as => :attachable
  has_many :terms, :through => :term_attachments
  
  has_many :career_attachments, :as => :attachable
  has_many :careers, :through => :career_attachments
  
  def name
    return title + " at " + company.name
  end
  
  def owned_by?(r)
    return company_id == r.company_id
  end
end
