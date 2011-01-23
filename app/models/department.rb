class Department < ActiveRecord::Base
  belongs_to :school
  has_many :courses
  has_one :term, :as => :reference
  
  after_create :create_term
  
  def create_term
    Term.new(:name => name, :reference => self).save
  end
  
end
