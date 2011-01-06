class Department < ActiveRecord::Base
  belongs_to :school
  belongs_to :term
  has_many :courses
end
