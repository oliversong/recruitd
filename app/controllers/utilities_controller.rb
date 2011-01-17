require 'delayed_job'

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
      actor_type = "Student"
      actor_id = current_user.entity_id
       
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
      actor_type = "Company"
      actor_id = current_user.entity.company_id
      
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
    
    Delayed::Job.enqueue ProcessFeedbackJob.new(actor_type, actor_id, params[:entity_type],params[:entity_id],ProcessFeedbackJob::STAR)
    
    @entity_id = params[:entity_id]
    @entity_type = params[:entity_type]
    render "shared/star"
  end
  
  def unstar
    if(params[:entity_id].empty?)
      render :nothing => true and return
    end
    
    if current_user.is_student? 
      actor_type = "Student"
      actor_id = current_user.entity_id
      
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
      actor_type = "Company"
      actor_id = current_user.entity.company_id
      
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
    
    Delayed::Job.enqueue ProcessFeedbackJob.new(actor_type, actor_id, params[:entity_type],params[:entity_id],ProcessFeedbackJob::UNSTAR)
    
    @entity_id = params[:entity_id]
    @entity_type = params[:entity_type]
    render "shared/star"
  end
  
  def vote
    #@voteable = Kernel.const_get(params[:voteable_type]).find(params[:voteable_id])
    
    if current_user.is_student?
      if (params[:voteable_type] == "Company")
        student_file = StudentFile.find_or_initialize_by_student_id_and_company_id(current_user.entity_id, params[:voteable_id])
        student_file.vote = params[:vote]
        student_file.save
        @vote = student_file.vote
      elsif (params[:voteable_type] == "Job")
        student_file = StudentFile.find_or_initialize_by_student_id_and_job_id(current_user.entity_id, params[:voteable_id])
        student_file.vote = params[:vote]
        student_file.save
        @vote = student_file.vote
      else
        #TODO render error
        render :nothing => true and return
      end
    elsif current_user.is_company_entity?
      if (params[:voteable_type] == "Student")
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.entity.company_id, params[:voteable_id])
        company_file.vote = params[:vote]
        company_file.save
        @vote = company_file.vote
      else
        #TODO render error
        render :nothing => true and return
      end
    end
    
    @voteable = Kernel.const_get(params[:voteable_type]).find(params[:voteable_id])
    render "shared/vote"
  end
  
  def tag
    if(params[:entity_id].empty?)
      render :nothing => true and return
    end
    
    if current_user.is_student?
    end
    
    if true
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
end
