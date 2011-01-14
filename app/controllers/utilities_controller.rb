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
end
