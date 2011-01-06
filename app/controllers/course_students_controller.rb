class CourseStudentsController < ApplicationController
  def index
    @course_students = CourseStudent.all
  end
  
  def show
    @course_student = CourseStudent.find(params[:id])
  end
  
  def new
    @course_student = CourseStudent.new
  end
  
  def create
    @course_student = CourseStudent.new(params[:course_student])
    if @course_student.save
      flash[:notice] = "Successfully created course student."
      redirect_to @course_student
    else
      render :action => 'new'
    end
  end
  
  def edit
    @course_student = CourseStudent.find(params[:id])
  end
  
  def update
    @course_student = CourseStudent.find(params[:id])
    if @course_student.update_attributes(params[:course_student])
      flash[:notice] = "Successfully updated course student."
      redirect_to @course_student
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @course_student = CourseStudent.find(params[:id])
    @course_student.destroy
    flash[:notice] = "Successfully destroyed course student."
    redirect_to course_students_url
  end
end
