require 'delayed_job'

class UtilitiesController < ApplicationController

  
  # authentications_controller.rb
  def authentications
    @authentications = current_user.user_tokens if current_user
  end
  
  def get_profile
      # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.

      def prepare_access_token(oauth_token, oauth_token_secret)
          consumer = OAuth::Consumer.new(APP_CONFIG["linkedin"]["api_key"], 
              APP_CONFIG["linkedin"]["api_secret"],
              { :site => "https://api.linkedin.com/uas/oauth/accessToken"
              })
          # now create the access token object from passed values
          token_hash = { :oauth_token => oauth_token,
                          :oauth_token_secret => oauth_token_secret
                       }
          access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
          return access_token
      end

      auth = current_user.user_tokens.find(:first, :conditions => { :provider => 'linked_in' })

      # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
      access_token = prepare_access_token(auth['token'], auth['secret'])

      # use the access token as an agent to get the home timeline
      response = access_token.request(:get, "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,headline,location:(name),summary,honors,interests,positions,publications,patents,languages,skills,educations,phone-numbers,main-address)")
      
      if current_user.is_student?
        current_user.entity.import_linkedin_xml(response.body)
      end
      
      render :json => response.body
  end

  # def create
  #     auth = request.env["rack.auth"]
  #     current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
  #     flash[:notice] = "Authentication successful."
  #     redirect_to authentications_url
  #   end
  # 
  #   def destroy
  #     @authentication = current_user.authentications.find(params[:id])
  #     @authentication.destroy
  #     flash[:notice] = "Successfully destroyed authentication."
  #     redirect_to authentications_url
  #   end
  #   
  #   
  
  
  
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
      actor_id = current_user.id
       
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
      actor_id = current_user.company_id
      
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
      actor_id = current_user.id
      
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
      actor_id = current_user.company_id
      
      if (params[:entity_type] == "Student")
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.company_id, params[:entity_id])
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
        student_file = StudentFile.find_or_initialize_by_student_id_and_company_id(current_user.id, params[:voteable_id])
        student_file.vote = params[:vote]
        student_file.save
        @vote = student_file.vote
      elsif (params[:voteable_type] == "Job")
        student_file = StudentFile.find_or_initialize_by_student_id_and_job_id(current_user.id, params[:voteable_id])
        student_file.vote = params[:vote]
        student_file.save
        @vote = student_file.vote
      else
        #TODO render error
        render :nothing => true and return
      end
    elsif current_user.is_company_entity?
      if (params[:voteable_type] == "Student")
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.company_id, params[:voteable_id])
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
        company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(current_user.company_id, params[:entity_id])
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
