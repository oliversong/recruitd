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
    end
    @user_id = params[:user_id]
    @followed = false
    render "shared/follow"
  end
end
