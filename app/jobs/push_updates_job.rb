class PushUpdatesJob < Struct.new(:updater_id, :update_id)
  #tentatively, some point values
  UP = 0
  DOWN = 1
  STAR = 2
  UNSTAR = 3
  
  POINTS = {UP => 1, DOWN => -1, STAR => 2, UNSTAR => -2}
  
    # t.text     "text"
    # t.string   "type"
    # t.integer  "reference_id"
    # t.string   "reference_type"
    # t.integer  "user_id"
    # t.integer  "entity_id"
    # t.string   "entity_type"
    # t.datetime "update_time"
  
  def perform
    #iterate through people following this user, and add newsfeed items for the update.
    updater = User.find(updater_id)
    update = Update.find(update_id)
    
    updater.followers.each do |follower|
      NewsfeedItem.new(:user_id => follower.id, 
                       :entity_id => updater.entity_id,
                       :entity_type => updater.entity_type,
                       :reference_id => update_id,
                       :reference_type => "Update",
                       :type => "Update",
                       :text => update.text
      )
    end
  end

  def perform_company_on_student
    if !POINTS.has_key?(action)
      puts "unknown action #{action}"
      return
    end
    
    #update baseline for student
    student = Student.find(subject_id)
    student.baseline_score += POINTS[action]
    student.save
    
    puts "baseline score for #{student.name} was changed to #{student.baseline_score}"
    
    #update career-specific weights for student
    company = Company.find(actor_id)
    company_career_ids = company.careers.map{|c| c.id}
    
    student.career_students.each do |cs|
      if company_career_ids.includes?(cs.career_id)
        cs.score += POINTS[action]
      end
    end
    
    #update tag weights for company
    
  end
  
  def perform_student_on_company
  end
  
  def perform_student_on_job
  end
  
  
end