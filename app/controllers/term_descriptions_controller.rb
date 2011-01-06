class TermDescriptionsController < ApplicationController
  # GET /tag_descriptions
  # GET /tag_descriptions.xml
  def index
    @tag_descriptions = TermDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tag_descriptions }
    end
  end

  # GET /tag_descriptions/1
  # GET /tag_descriptions/1.xml
  def show
    @tag_description = TermDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag_description }
    end
  end

  # GET /tag_descriptions/new
  # GET /tag_descriptions/new.xml
  def new
    @tag_description = TermDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag_description }
    end
  end

  # GET /tag_descriptions/1/edit
  def edit
    @tag_description = TermDescription.find(params[:id])
  end

  # POST /tag_descriptions
  # POST /tag_descriptions.xml
  def create
    @tag_description = TermDescription.new(params[:term_description])

    respond_to do |format|
      if @tag_description.save
        format.html { redirect_to(@tag_description, :notice => 'TermDescription was successfully created.') }
        format.xml  { render :xml => @tag_description, :status => :created, :location => @tag_description }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tag_descriptions/1
  # PUT /tag_descriptions/1.xml
  def update
    @tag_description = TermDescription.find(params[:id])

    respond_to do |format|
      if @tag_description.update_attributes(params[:term_description])
        format.html { redirect_to(@tag_description, :notice => 'TermDescription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_descriptions/1
  # DELETE /tag_descriptions/1.xml
  def destroy
    @tag_description = TermDescription.find(params[:id])
    @tag_description.destroy

    respond_to do |format|
      format.html { redirect_to(tag_descriptions_url) }
      format.xml  { head :ok }
    end
  end
end
