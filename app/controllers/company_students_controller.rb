class CompanyStudentsController < ApplicationController
  # GET /company_students
  # GET /company_students.xml
  def index
    @company_students = CompanyStudent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @company_students }
    end
  end

  # GET /company_students/1
  # GET /company_students/1.xml
  def show
    @company_student = CompanyStudent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company_student }
    end
  end

  # GET /company_students/new
  # GET /company_students/new.xml
  def new
    @company_student = CompanyStudent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company_student }
    end
  end

  # GET /company_students/1/edit
  def edit
    @company_student = CompanyStudent.find(params[:id])
  end

  # POST /company_students
  # POST /company_students.xml
  def create
    @company_student = CompanyStudent.new(params[:company_student])

    respond_to do |format|
      if @company_student.save
        format.html { redirect_to(@company_student, :notice => 'CompanyStudent was successfully created.') }
        format.xml  { render :xml => @company_student, :status => :created, :location => @company_student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /company_students/1
  # PUT /company_students/1.xml
  def update
    @company_student = CompanyStudent.find(params[:id])

    respond_to do |format|
      if @company_student.update_attributes(params[:company_student])
        format.html { redirect_to(@company_student, :notice => 'CompanyStudent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company_students/1
  # DELETE /company_students/1.xml
  def destroy
    @company_student = CompanyStudent.find(params[:id])
    @company_student.destroy

    respond_to do |format|
      format.html { redirect_to(company_students_url) }
      format.xml  { head :ok }
    end
  end
end
