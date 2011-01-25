class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end
  
  def show
    @job = Job.find(params[:id])
    
    if current_user.is_student?
      @student_file = StudentFile.find_or_initialize_by_student_id_and_applyable_id_and_applyable_type(current_user.id, params[:id], "Job")
    end
    
    
  end
  
  def new
    @job = Job.new
    render "new"
  end
  
  def create
    if !current_user.is_company_entity?
      raise CanCan::AccessDenied
    end
    
    @job = Job.new(params[:job])
    @job.company = current_user.company
    
    if(params[:career])
      params[:career].values.each do |career_name|
        career = Career.find_by_name(career_name)
        if career
          @job.careers << career
        end
      end
    end
    
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
  
  def star
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    @student = current_user.entity
    @job = Job.find(params[:id])
    
    student_feed = StudentFeed.find_by_student_id_and_job_id(@student.id, @job.id)
    if(student_feed)
      student_feed.deleted = true
      student_feed.save
    end
    
    student_file = StudentFile.find_by_student_id_and_job_id(@student.id, @job.id)
    if(!student_file)
      student_file = StudentFile.new(:student_id => @student.id, :company_id => @job.id)
    end
    
    student_file.starred = true
    student_file.save
    
    redirect_to :back
  end
  
  def dismiss
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    @student = current_user.entity
    @job = Job.find(params[:id])

    student_feed = StudentFeed.find_by_student_id_and_job_id(@student.id, @job.id)
    if(student_feed)
      student_feed.dismissed = true
      student_feed.save
    end
    redirect_to :back

  end
  
  def update_file
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    @job = Job.find(params[:id])
    
    student_file = StudentFile.find_or_initialize_by_student_id_and_job_id(@student.id, @job.id)
    student_file.update_attributes(params[:student_file_student_file_job])
    redirect_to :back
  end
  
end
