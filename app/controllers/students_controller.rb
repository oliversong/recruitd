class StudentsController < ApplicationController
  before_filter :require_person, :only => [:home]
  
  #auto_complete_for :course, :name
  
  # GET /students
  # GET /students.xml
  def index
    @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end
  
  def home
    @student = current_person.student
    @person = current_person
  end
  
  def my_companies
    @student = current_person.student
    @student_files = @student.student_files
    @student_files_companies = @student_files.find_all_by_type("StudentFileCompany")
    @student_files_jobs = @student_files.find_all_by_type("StudentFileJob")
  end
  
  def add_experience
    @student = current_person.student
    @work_experience = WorkExperience.new
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @updates = @student.person.updates

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student, :notice => 'Student was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
end
