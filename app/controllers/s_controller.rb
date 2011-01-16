class SController < ApplicationController
  def manage
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    
    @student_files = @student.student_files
    @student_files_companies = @student_files.find_all_by_type("StudentFile::StudentFileCompany")
    @student_files_jobs = @student_files.find_all_by_type("StudentFile::StudentFileJob")
    
    @starred_student_files = @student_files.select{|student_file| student_file.starred }
  end
  

  def home
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity

  end
  
  def add_career
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    
    if(params[:career][:id]) #existing club
      if(params[:career][:description_changed]) #amend the description
        @career = Career.find(params[:career][:id])
        @career.description = params[:career][:description]
        @career.save
      end
    else #new club
      @career = Career.new(params[:career])
      @career.save
    end
    
    @career_student = CareerStudent.new(:student_id => @student.id, :career_id => params[:career][:id])
    if @career_student.save
      flash[:notice] = "Successfully added career."
    end
    redirect_to @student
  end


  def add_course
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    
    if(params[:course][:id]) #existing club
      # if(params[:course][:description_changed]) #amend the description
      #   @course = Course.find(params[:course][:id])
      #   @course.description = params[:course][:description]
      #   @course.save
      # end
    else #new club
      @course = Course.new(params[:course])
      @course.save
    end
    
    @course_student = CourseStudent.new(:student_id => @student.id, :course_id => params[:course][:id], :comments => params[:course][:comments])
    if @course_student.save
      flash[:notice] = "Successfully added course."
    end
    redirect_to @student
  end
  
  def add_award
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    
    if(params[:award][:id] && !params[:award][:id].empty?) #existing club
      # if(params[:course][:description_changed]) #amend the description
      #   @course = Course.find(params[:course][:id])
      #   @course.description = params[:course][:description]
      #   @course.save
      # end
      @award = Term::Award.find(params[:award][:id])
    else #new club
      @award = Term::Award.new(params[:award])
      @award.save
    end
    
    @student_award = StudentAward.new(:student_id => @student.id, :term_id => @award.id, :details => params[:comments])
    if @student_award.save
      flash[:notice] = "Successfully added award."
    end
    redirect_to @student
  end
  
  def add_interest
    if !current_user.is_student?
      redirect_to :new_user_session
    end

    @student = current_user.entity

    if(params[:interest][:id] && !params[:interest][:id].empty?) #existing club
      # if(params[:course][:description_changed]) #amend the description
      #   @course = Course.find(params[:course][:id])
      #   @course.description = params[:course][:description]
      #   @course.save
      # end
      @interest = Term::Interest.find(params[:interest][:id])
    else #new club
      @interest = Term::Interest.new(params[:interest])
      @interest.save
    end

    @student_interest = StudentInterest.new(:student_id => @student.id, :term_id => @interest.id, :details => params[:comments])
    if @student_interest.save
      flash[:notice] = "Successfully added interest."
    end
    redirect_to @student
  end
  
  def browse
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @page = params[:page] ? [Integer(params[:page]), 0].max : 0
    
    #@student = current_user.entity
    
    @student_feed = StudentFeed.by_student_id(current_user.entity_id).offset(@page).limit(1).find(:first)
    
    if @student_feed.company_id
      @followed = !!Following.find_by_follower_id_and_followed_id( current_user.id, @student_feed.company.user_id)
    end
    
    @student_file = StudentFile.find_or_initialize_by_student_id_and_company_id( current_user.entity_id, @student_feed.company_id)
    
  end
  
  def settings
  end
end
