require_dependency 'experience'

class ExperiencesController < ApplicationController
  def index
    @experiences = Experience.all
  end
  
  def show
    @experience = Experience.find(params[:id])
  end
  
  def new
    @student = current_user.student
    @experience = Experience.new
  end
  
  def create
    puts params.to_yaml
    if(params[:experience_type] == "club")
      
      #START BY CREATING/MODIFYING CLUB
      if(params[:club][:id]) #existing club
        if(params[:club][:description_changed]) #amend the description
          @club = Club.find(params[:club][:id])
          @club.description = params[:club][:description]
        end
      else #new club
        @club = Club.new(params[:club])
      end
      @club.save
      
      #NOW MODIFY EXPEIRENCE
      @experience = ClubExperience.new(params[:experience])
      @experience.student_id = current_user.student.id
      @experience.club = @club
    else
      
      #START BY CREATING COMPANY
      if(params[:club][:id]) #new company
        @company = Company.find(params[:club][:id])
      else
        @company = Company.new(params[:club])
        @company.save
      end
      
      #NOW MODIFY EXPEIRENCE
      @experience = WorkExperience.new(params[:experience])
      @experience.student_id = current_user.student.id
      @experience.company = @company
    end
    
    
    if @experience.save
      flash[:notice] = "Successfully created experience."
      redirect_to @experience.becomes(Experience)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @experience = Experience.find(params[:id])
  end
  
  def update
    @experience = Experience.find(params[:id])
    if @experience.update_attributes(params[:experience])
      flash[:notice] = "Successfully updated experience."
      redirect_to @experience
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    flash[:notice] = "Successfully destroyed experience."
    redirect_to experiences_url
  end
end
