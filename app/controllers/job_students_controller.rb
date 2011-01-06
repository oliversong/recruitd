class JobStudentsController < ApplicationController
  # GET /job_students
  # GET /job_students.xml
  def index
    @job_students = JobStudent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @job_students }
    end
  end

  # GET /job_students/1
  # GET /job_students/1.xml
  def show
    @job_student = JobStudent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job_student }
    end
  end

  # GET /job_students/new
  # GET /job_students/new.xml
  def new
    @job_student = JobStudent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job_student }
    end
  end

  # GET /job_students/1/edit
  def edit
    @job_student = JobStudent.find(params[:id])
  end

  # POST /job_students
  # POST /job_students.xml
  def create
    @job_student = JobStudent.new(params[:job_student])

    respond_to do |format|
      if @job_student.save
        format.html { redirect_to(@job_student, :notice => 'JobStudent was successfully created.') }
        format.xml  { render :xml => @job_student, :status => :created, :location => @job_student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /job_students/1
  # PUT /job_students/1.xml
  def update
    @job_student = JobStudent.find(params[:id])

    respond_to do |format|
      if @job_student.update_attributes(params[:job_student])
        format.html { redirect_to(@job_student, :notice => 'JobStudent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /job_students/1
  # DELETE /job_students/1.xml
  def destroy
    @job_student = JobStudent.find(params[:id])
    @job_student.destroy

    respond_to do |format|
      format.html { redirect_to(job_students_url) }
      format.xml  { head :ok }
    end
  end
end
