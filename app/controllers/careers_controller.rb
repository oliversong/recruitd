class CareersController < ApplicationController
  def index
    @careers = Career.all
  end
  
  def show
    @career = Career.find(params[:id])
  end
  
  def tags
    @career = Career.find(params[:id])
  end
  
  
  def new
    @career = Career.new
  end
  
  def create
    @career = Career.new(params[:career])
    if @career.save
      flash[:notice] = "Successfully created career."
      redirect_to @career
    else
      render :action => 'new'
    end
  end
  
  def edit
    @career = Career.find(params[:id])
  end
  
  def update
    @career = Career.find(params[:id])
    if @career.update_attributes(params[:career])
      flash[:notice] = "Successfully updated career."
      redirect_to @career
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @career = Career.find(params[:id])
    @career.destroy
    flash[:notice] = "Successfully destroyed career."
    redirect_to careers_url
  end
end
