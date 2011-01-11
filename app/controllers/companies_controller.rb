class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
    @student = current_user.entity
    @student_file_company = StudentFileCompany.find_or_initialize_by_student_id_and_company_id(@student.id, @company.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
  
  def my_students
  end
  
  def rate
    @student = current_user.entity
    @company = Company.find(params[:id])
    student_file = StudentFileCompany.find_or_initialize_by_student_id_and_company_id(@student.id, @company.id)
    student_file.update_attributes(params[:student_file_student_file_company])
    redirect_to :action => :show, :id => @company
  end
  
  def star
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    @student = current_user.entity
    @company = Company.find(params[:id])
    
    student_feed = StudentFeed.find_by_student_id_and_company_id(@student.id, @company.id)
    if(student_feed)
      student_feed.deleted = true
      student_feed.save
    end
    
    student_file = StudentFile.find_by_student_id_and_company_id(@student.id, @company.id)
    if(!student_file)
      student_file = StudentFile.new(:student_id => @student.id, :company_id => @company.id)
    end
    
    student_file.starred = true
    student_file.save
    
    redirect_to home_s_path
  end
  
  def dismiss
    if !current_user.is_student?
      redirect_to :new_user_session
    end
    @student = current_user.entity
    @company = Company.find(params[:id])
    
    student_feed = StudentFeed.find_by_student_id_and_company_id(@student.id, @company.id)
    if(student_feed)
      student_feed.dismissed = true
      student_feed.save
    end
    redirect_to home_s_path
    
  end
end
