class StudentTermsController < ApplicationController
  # GET /student_terms
  # GET /student_terms.xml
  def index
    @student_terms = StudentTerm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_terms }
    end
  end

  # GET /student_terms/1
  # GET /student_terms/1.xml
  def show
    @student_term = StudentTerm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_term }
    end
  end

  # GET /student_terms/new
  # GET /student_terms/new.xml
  def new
    @student_term = StudentTerm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_term }
    end
  end

  # GET /student_terms/1/edit
  def edit
    @student_term = StudentTerm.find(params[:id])
  end

  # POST /student_terms
  # POST /student_terms.xml
  def create
    @student_term = StudentTerm.new(params[:student_term])

    respond_to do |format|
      if @student_term.save
        format.html { redirect_to(@student_term, :notice => 'StudentTerm was successfully created.') }
        format.xml  { render :xml => @student_term, :status => :created, :location => @student_term }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student_term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /student_terms/1
  # PUT /student_terms/1.xml
  def update
    @student_term = StudentTerm.find(params[:id])

    respond_to do |format|
      if @student_term.update_attributes(params[:student_term])
        format.html { redirect_to(@student_term, :notice => 'StudentTerm was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student_term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /student_terms/1
  # DELETE /student_terms/1.xml
  def destroy
    @student_term = StudentTerm.find(params[:id])
    @student_term.destroy

    respond_to do |format|
      format.html { redirect_to(student_terms_url) }
      format.xml  { head :ok }
    end
  end
end
