class StudentsController < ApplicationController
  load_and_authorize_resource
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

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])
    @updates = @student.updates
    
    @owner = (current_user.id == @student.id)
    if @owner
      @current_tab = User::TABS["PUBLIC"]
    end
    
    if current_user.is_company_entity?
      @company_file = CompanyFile.find_or_initialize_by_student_id_and_company_id(params[:id], current_user.company_id)
      
      chs = CompanyHighlighting.find_all_by_company_id_and_student_id(current_user.company_id, params[:id])
      @company_highlightings = chs.map{|ch| [ch.reference_type, ch.reference_id]}
    end
    
    @followed = !!Following.find_by_follower_id_and_followed_id( current_user.id, @student.id)
    
    respond_to do |type|
      type.html { render 'show' }
      type.json {render :json => @student}
    end
    
    
  end
  
  

  # # GET /students/new
  # # GET /students/new.xml
  # def new
  #   @student = Student.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @student }
  #   end
  # end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # # POST /students
  # # POST /students.xml
  # def create
  #   @student = Student.new(params[:student])
  # 
  #   respond_to do |format|
  #     if @student.save
  #       format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
  #       format.xml  { render :xml => @student, :status => :created, :location => @student }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])
    if @student != current_user
      redirect_to(:back, :notice => 'Not authorized.')
    end

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

  # # DELETE /students/1
  # # DELETE /students/1.xml
  # def destroy
  #   @student = Student.find(params[:id])
  #   @student.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(students_url) }
  #     format.xml  { head :ok }
  #   end
  # end
  
  def update_file
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    @company = current_user.company
    @student = Student.find(params[:id])
    
    company_file = CompanyFile.find_or_initialize_by_student_id_and_company_id(@student.id, @company.id)
    company_file.update_attributes(params[:company_file])
    redirect_to :back
  end
  
  def star
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    @company = current_user.entity.company
    @student = Student.find(params[:id])
    
    company_feed = CompanyFeed.find_by_student_id_and_company_id(@student.id, @company.id)
    if(company_feed)
      company_feed.deleted = true
      company_feed.save
    end
    
    company_file = CompanyFile.find_by_student_id_and_company_id(@student.id, @company.id)
    if(!company_file)
      company_file = CompanyFile.new(:student_id => @student.id, :company_id => @company.id)
    end
    
    company_file.starred = true
    company_file.save
    
    redirect_to :back
  end
  
  def dismiss
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    @company = current_user.entity.company
    @student = Student.find(params[:id])
    
    company_feed = CompanyFeed.find_by_student_id_and_company_id(@student.id, @company.id)
    if(company_feed)
      company_feed.dismissed = true
      company_feed.save
    end
    
    redirect_to :back  
  end
  
  def build
    @student = current_user
    render 'build'
  end
  
end
