class StudentLabeling < ActiveRecord::Base
  belongs_to :student
  belongs_to :label
  
  #one of these
  belongs_to :applyable, :polymorphic => true
  belongs_to :student_file
  
  #scope :by_student, lambda { |student| :where(:student => student) }
  
  after_create :create_student_file
  
  def create_student_file
    if !student_file_id
      sf = StudentFile.find_or_create_by_student_id_and_applyable_id_and_applyable_type(student_id, applyable_id, applyable_type)
      self.student_file_id = sf.id
      self.save
    end
  end
end
