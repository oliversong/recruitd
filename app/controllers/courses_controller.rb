class CoursesController < ApplicationController
  # def index
  #   @courses = Course.all
  # end
  
  def show
    @course = Course.find(params[:id])
    @term_descriptions = @course.term_descriptions
    
    @students = @course.students
    @jobs = @course.jobs
    @careers = @course.careers
    @comments = @course.comments.recent.limit(10).all
    
    if current_user.is_company_entity?
      @followed = !!CompanyTerm.find_by_company_id_and_term_id(current_user.company_id, @course.id)
    end
    
    if current_user.is_student?
      @course_rating = CourseRating.find_by_student_id_and_course_id(current_user.id, params[:id])
    end
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:notice] = "Successfully created course."
      redirect_to @course
    else
      render :action => 'new'
    end
  end
  
  def edit
    @course = Course.find(params[:id])
  end
  
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = "Successfully updated course."
      redirect_to @course
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Successfully destroyed course."
    redirect_to courses_url
  end
  
  #method: PUT
  def rate
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @course = Course.find(params[:id])
    @course_rating = CourseRating.find_by_student_id_and_course_id(current_user.entity_id, params[:id])
    if !@course_rating
      @course_rating = CourseRating.new(:student_id => current_user.entity_id, :course_id => params[:id])
    end
    
    if params[:course_rating][:difficulty] && !params[:course_rating][:difficulty].empty?
      @course_rating.difficulty = params[:course_rating][:difficulty]
    end
    
    if params[:course_rating][:usefulness] && !params[:course_rating][:usefulness].empty?
      @course_rating.usefulness = params[:course_rating][:usefulness]
    end
    
    @course_rating.save
    redirect_to @course
  end
end
