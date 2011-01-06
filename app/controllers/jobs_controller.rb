class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end
  
  def show
    @job = Job.find(params[:id])
    @student = current_person.student
    @student_file_job = StudentFile.find_or_initialize_by_student_id_and_job_id(@student.id, @job.id)
  end
  
  def rate
    @student = current_person.student
    student_file = StudentFile::StudentFileJob.find_or_initialize_by_student_id_and_job_id(@student.id, params[:id])
    student_file.update_attributes(params[:student_file_student_file_job])
    redirect_to :action => :show, :id => params[:id]
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Successfully created job."
      redirect_to @job
    else
      render :action => 'new'
    end
  end
  
  def edit
    @job = Job.find(params[:id])
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = "Successfully updated job."
      redirect_to @job
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = "Successfully destroyed job."
    redirect_to jobs_url
  end
end
