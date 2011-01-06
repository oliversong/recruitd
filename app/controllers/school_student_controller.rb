class SchoolStudentsController < ApplicationController
  # GET /school_students
  # GET /school_students.xml
  def index
    @school_students = SchoolStudent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @school_students }
    end
  end

  # GET /school_students/1
  # GET /school_students/1.xml
  def show
    @school_student = SchoolStudent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school_student }
    end
  end

  # GET /school_students/new
  # GET /school_students/new.xml
  def new
    @school_student = SchoolStudent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school_student }
    end
  end

  # GET /school_students/1/edit
  def edit
    @school_student = SchoolStudent.find(params[:id])
  end

  # POST /school_students
  # POST /school_students.xml
  def create
    @school_student = SchoolStudent.new(params[:school_student])

    respond_to do |format|
      if @school_student.save
        format.html { redirect_to(@school_student, :notice => 'SchoolStudent was successfully created.') }
        format.xml  { render :xml => @school_student, :status => :created, :location => @school_student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /school_students/1
  # PUT /school_students/1.xml
  def update
    @school_student = SchoolStudent.find(params[:id])

    respond_to do |format|
      if @school_student.update_attributes(params[:school_student])
        format.html { redirect_to(@school_student, :notice => 'SchoolStudent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @school_student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /school_students/1
  # DELETE /school_students/1.xml
  def destroy
    @school_student = SchoolStudent.find(params[:id])
    @school_student.destroy

    respond_to do |format|
      format.html { redirect_to(school_students_url) }
      format.xml  { head :ok }
    end
  end
end
