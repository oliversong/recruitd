class RepTransaction < ActiveRecord::Base
  belongs_to :person
  
  validates_numericality_of :rep_change
  
  before_save :increment_rep_of_person
  
  def increment_rep_of_person
    person.rep_alltime += @rep_transaction.rep_change
    person.rep_month += @rep_transaction.rep_change
    person.save
  end
end
