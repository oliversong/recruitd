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
    if current_user.is_student? 
      if (params[:entity_type] == "Company")
        
      elsif (params[:entity_type] == "Job")
        
      else
        #TODO render error
        render :nothing => true
      end
      
      
    elsif current_user.is_company_entity?
    end
    
    following = Following.find_by_follower_id_and_followed_id(current_user.id, params[:user_id])
    if following
      following.destroy
    else
    end
    @user_id = params[:user_id]
    @followed = false
    render "shared/follow"
  end
  
  def unstar
  end
end
