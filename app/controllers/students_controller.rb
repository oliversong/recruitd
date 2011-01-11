class StudentsController < ApplicationController
  #before_filter :require_user, :only => [:home]
  
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
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
  end
  
  def my_companies
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    
    @student = current_user.entity
    
    @student_files = @student.student_files
    @student_files_companies = @student_files.find_all_by_type("StudentFileCompany")
    @student_files_jobs = @student_files.find_all_by_type("StudentFileJob")
  end
  
  def add_experience
    @student = current_user.student
    @work_experience = WorkExperience.new
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


  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @updates = @student.user.updates

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
