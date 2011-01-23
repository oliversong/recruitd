class Department < ActiveRecord::Base
  belongs_to :school
  has_many :courses
  has_one :term, :as => :reference
end
