class AutocompleteSearchesController < ApplicationController

  def course_names
    @courses = Course.limit(10).search_for_name(params[:term])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def club_names
    @clubs = Club.limit(10).search_for_name(params[:term])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def company_names
    @companies = Company.limit(10).search_for_name(params[:term])
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  # #for sphinx
  # def index
  #   @some_models = SomeModel.search params[:term],
  #                                   :limit => 5,
  #                                   :match_mode => :any,
  #                                   :field_weights => { :name => 20, :description => 10, :reviews_content => 5 }
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  
end