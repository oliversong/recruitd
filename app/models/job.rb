class Job < ActiveRecord::Base
  belongs_to :company
  has_many :career_jobs
  has_many :careers, :through => :career_jobs
  
  def name
    return title + " at " + company.name
  end
end
