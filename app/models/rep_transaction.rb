class RepTransaction < ActiveRecord::Base
  belongs_to :user
  
  validates_numericality_of :rep_change
  
  before_save :increment_rep_of_user
  
  def increment_rep_of_user
    user.rep_alltime += @rep_transaction.rep_change
    user.rep_month += @rep_transaction.rep_change
    user.save
  end
end
