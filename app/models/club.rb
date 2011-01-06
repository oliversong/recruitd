class Club < ActiveRecord::Base
  belongs_to :term
  belongs_to :added_by_person, :class_name => "Person"
  has_many :club_experiences
  has_many :students, :through => :club_experiences
  
  named_scope :limit, lambda { |limit| {:limit => limit} }
  
  named_scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
end
