class Term < ActiveRecord::Base
  has_many :term_descriptions #, :order => "position"
  has_many :student_terms
  has_many :students, :through => :student_terms
  belongs_to :category
end

class Interest < Term
end

class Award < Term
end