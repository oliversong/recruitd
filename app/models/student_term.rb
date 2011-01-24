class StudentTerm < ActiveRecord::Base
  belongs_to :student
  belongs_to :term
  
  scope :only_awards, :conditions => ["term_type = ?", "Award"]
  scope :only_interests, :conditions => ["term_type = ?", "Interest"]
    
    
  after_create :assign_term_type
  
  def assign_term_type
    if term_type.blank?
      self.term_type = term.type
      self.save
    end
  end
end