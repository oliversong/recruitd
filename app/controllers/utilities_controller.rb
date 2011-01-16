class UtilitiesController < ApplicationController
  
  def follow
    Following.find_or_create_by_follower_id_and_followed_id(current_user.id, params[:user_id])
    @user_id = params[:user_id]
    @followed = true
    render "shared/follow"
  end
  
  def unfollow
    following = Following.find_by_follower_id_and_followed_id(current_user.id, params[:user_id])
    if following
      following.destroy
    else
    end
    @user_id = params[:user_id]
    @followed = false
    render "shared/follow"
    
    
    # respond_to do |format|
    #       format.html do
    #         if request.xhr?
    #           render :partial => "shared/follow", :locals => {:user_id=>@user_id, :followed => @followed}, :layout => false
    #         else
    #           redirect_to :back
    #         end
    #       end
    #     end
  end
  
  def star
    if(params[:entity_id].empty?)
      render :nothing => true and return
    end
    
    if current_user.is_student? 
      if (params[:entity_type] == "Company")
        student_file = StudentFile.find_or_initialize_by_student_id_and_company_id(current_user.id, params[:entity_id])
        student_file.starred = true
        student_file.save        
        @starred = true
      elsif (params[:entity_type] == "Job")
        student_file = StudentFile.find_or_initialize_by_student_id_and_job_id(current_user.id, params[:entity_id])
        student_file.starred = true
        student_file.save
        @starred = true
      else
        #TODO render error
        render :nothing => true and return
      end
    elsif current_user.is_company_entity?
      if (params[:entity_type] == "Student")
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.entity.company_id, params[:entity_id])
        company_file.starred = true
        company_file.save
        @starred = true
      else
        #TODO render error
        render :nothing => true and return
      end
    end
    
    @entity_id = params[:entity_id]
    @entity_type = params[:entity_type]
    render "shared/star"
  end
  
  def unstar
    if(params[:entity_id].empty?)
      render :nothing => true and return
    end
    
    if current_user.is_student? 
      if (params[:entity_type] == "Company")
        student_file = StudentFile.find_or_initialize_by_student_id_and_company_id(current_user.id, params[:entity_id])
        student_file.starred = false
        student_file.save
        @starred = false
      elsif (params[:entity_type] == "Job")
        student_file = StudentFile.find_or_initialize_by_student_id_and_job_id(current_user.id, params[:entity_id])
        student_file.starred = false
        student_file.save
        @starred = false
      else
        #TODO render error
        render :nothing => true and return
      end
    elsif current_user.is_company_entity?
      if (params[:entity_type] == "Student")
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.entity.company_id, params[:entity_id])
        company_file.starred = false
        company_file.save
        @starred = false
      else
        #TODO render error
        render :nothing => true and return
      end
    end
    
    @entity_id = params[:entity_id]
    @entity_type = params[:entity_type]
    render "shared/star"
  end
end
