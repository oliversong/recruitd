class UpdateRecommendationsJob < Struct.new(:entity_type, :entity_id)
  def perform
    if entity_type == "Student"
      perform_student
    elsif entity_type == "Company"
      perform_company      
    end
    
    #entity = Kernel.const_get(entity_type).find(entity_id)
  end
  
  def perform_student
    
  end
  
  def perform_company
    #find company career interests
    company = Company.find(entity_id)
    
    Student.find(:all, :order => "baseline_score", :limit => 100, :include => :careers).each do |student|
      #start by adding baseline score
      total_score = student.baseline_score
      
      #now add in max score out of all relevant careers
      max_career_score = 0
      student.career_students.each do |cs|
        if cs.score > max_career_score && company.careers.include?(cs.career)
          max_career_score = cs.score
        end
      end
      
      # now for each term tagged, sum up
      sum_term_scores = 0
      student.student_terms.each do |st|
        idx = company.company_terms.index{ |ct| ct.term_id = st.term_id }
        if idx #match
          sum_term_scores += company.company_terms[idx].weight*st.score
        end
      end 
      
      total_score += max_career_score
      total_score += sum_term_scores
      
      #assign to feed
      company_feed = CompanyFeed.find_or_initialize_by_company_id_and_student_id(entity_id, student.id)
      company_feed.score = total_score
      company_feed.save
    end
  end
end