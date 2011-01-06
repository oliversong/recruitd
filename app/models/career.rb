class Career < ActiveRecord::Base
  belongs_to :term
  has_many :career_jobs
  has_many :jobs, :through => :career_jobs
end
