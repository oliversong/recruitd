class SController < ApplicationController

  
  # def add_career
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  #     
  #     @student = current_user.entity
  #     
  #     if(params[:career][:id]) #existing club
  #       if(params[:career][:description_changed]) #amend the description
  #         @career = Career.find(params[:career][:id])
  #         @career.description = params[:career][:description]
  #         @career.save
  #       end
  #     else #new club
  #       @career = Career.new(params[:career])
  #       @career.save
  #     end
  #     
  #     @career_student = CareerStudent.new(:student_id => @student.id, :career_id => params[:career][:id])
  #     if @career_student.save
  #       flash[:notice] = "Successfully added career."
  #     end
  #     redirect_to @student
  #   end
  #   
  #   def delete_career
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  #     
  #     career_student = CareerStudent.find_by_student_id_and_career_id(current_user.entity_id, params[:id])
  #     if(career_student)
  #       career_student.destroy
  #     end
  #     
  #     redirect_to :back
  #   end


  # def add_course
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  #     
  #     @student = current_user.entity
  #     
  #     if(params[:course][:id]) #existing club
  #       # if(params[:course][:description_changed]) #amend the description
  #       #   @course = Course.find(params[:course][:id])
  #       #   @course.description = params[:course][:description]
  #       #   @course.save
  #       # end
  #     else #new club
  #       @course = Course.new(params[:course])
  #       @course.save
  #     end
  #     
  #     @course_student = CourseStudent.new(:student_id => @student.id, :course_id => params[:course][:id], :comments => params[:course][:comments])
  #     if @course_student.save
  #       flash[:notice] = "Successfully added course."
  #     end
  #     redirect_to @student
  #   end
  #   
  #   def delete_course
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  #     
  #     course_student = CourseStudent.find_by_student_id_and_course_id(current_user.entity_id, params[:id])
  #     if(course_student)
  #       course_student.destroy
  #     end
  #     
  #     redirect_to :back
  #   end
  #   
  #   def add_award
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  #     
  #     @student = current_user.entity
  #     
  #     if(params[:award][:id] && !params[:award][:id].empty?) #existing club
  #       # if(params[:course][:description_changed]) #amend the description
  #       #   @course = Course.find(params[:course][:id])
  #       #   @course.description = params[:course][:description]
  #       #   @course.save
  #       # end
  #       @award = Term::Award.find(params[:award][:id])
  #     else #new club
  #       @award = Term::Award.new(params[:award])
  #       @award.save
  #     end
  #     
  #     @student_award = StudentTerm.new(:student_id => @student.id, :term_id => @award.id, :details => params[:comments], :term_type => "Award")
  #     if @student_award.save
  #       flash[:notice] = "Successfully added award."
  #     end
  #     redirect_to @student
  #   end
  #   
  def add_term
    if !current_user.is_student?
      redirect_to :new_user_session
    end

    @student = current_user

    if(params[:term][:id] && !params[:term][:id].empty?) #existing club
      # if(params[:course][:description_changed]) #amend the description
      #   @course = Course.find(params[:course][:id])
      #   @course.description = params[:course][:description]
      #   @course.save
      # end
      @term = Term.find(params[:term][:id])
    else #new item
      
      case params[:term][:type]
        when "Award", "Interest", "Skill" then
          @term = Term.new(:name => params[:term][:name], :type => params[:term][:type])
          @term.save
        when "Career" then
          #DON'T make new career...
          flash[:notice] = "You are not authorized to add new careers."
          redirect_to :back and return
        when "Course" then
          # make new course
          course = Course.new(:name => params[:term][:name])
          course.save
          @term = Term.new(:name => params[:term][:name], :reference => course)
          @term.save
        when "Club" then
          # make new club
          club = Club.new(:name => params[:term][:name])
          club.save
          @term = Term.new(:name => params[:term][:name], :reference => club)
          @term.save
        else
      end
    end

    @student_term = StudentTerm.new(:student_id => @student.id, :term_id => @term.id, :details => params[:comments], :term_type => "Skill")
    if @student_term.save
      flash[:notice] = "Successfully added interest."
    end
    redirect_to :back
  end
  
  def delete_term
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    student_term = StudentTerm.find_by_student_id_and_term_id(current_user.entity_id, params[:id])
    if(student_term)
      student_term.destroy
    end
    
    redirect_to :back
  end
  
  # def add_interest
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  # 
  #     @student = current_user.entity
  # 
  #     if(params[:interest][:id] && !params[:interest][:id].empty?) #existing club
  #       # if(params[:course][:description_changed]) #amend the description
  #       #   @course = Course.find(params[:course][:id])
  #       #   @course.description = params[:course][:description]
  #       #   @course.save
  #       # end
  #       @interest = Term::Interest.find(params[:interest][:id])
  #     else #new club
  #       @interest = Term::Interest.new(params[:interest])
  #       @interest.save
  #     end
  # 
  #     @student_interest = StudentTerm.new(:student_id => @student.id, :term_id => @interest.id, :details => params[:comments], :term_type => "Interest")
  #     if @student_interest.save
  #       flash[:notice] = "Successfully added interest."
  #     end
  #     redirect_to @student
  #   end
  #   
  #   def add_skill
  #     if !current_user.is_student?
  #       redirect_to :new_user_session
  #     end
  # 
  #     @student = current_user.entity
  # 
  #     if(params[:skill][:id] && !params[:skill][:id].empty?) #existing club
  #       # if(params[:course][:description_changed]) #amend the description
  #       #   @course = Course.find(params[:course][:id])
  #       #   @course.description = params[:course][:description]
  #       #   @course.save
  #       # end
  #       @skill = Term::Skill.find(params[:skill][:id])
  #     else #new club
  #       @skill = Term::Skill.new(params[:skill])
  #       @skill.save
  #     end
  # 
  #     @student_term = StudentTerm.new(:student_id => @student.id, :term_id => @skill.id, :details => params[:comments], :term_type => "Skill")
  #     if @student_term.save
  #       flash[:notice] = "Successfully added interest."
  #     end
  #     redirect_to @student
  #   end
  

  

end
