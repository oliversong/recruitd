class Club < Term
  belongs_to :added_by_user, :class_name => "User"
  has_many :club_experiences
  has_many :students, :through => :club_experiences
  
  #scope :limit, lambda { |limit| {:limit => limit} }
  
  scope :search_for_name, lambda { |term| {:conditions => ['lower(name) LIKE ?', "%#{term.downcase}%" ]} }
  
  # after_create :create_term
  # 
  # def create_term
  #   Term.new(:name => name, :reference => self).save
  # end
  
end
