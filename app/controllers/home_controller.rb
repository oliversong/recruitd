class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "home"
    @topics = Topic.find_recent
    @members = User.find_recent
    if logged_in?
      @feed = current_user.feed
      @some_contacts = current_user.some_contacts
      @requested_contacts = current_user.requested_contacts
    else
      @feed = Activity.global_feed
    end    
    respond_to do |format|
      format.html
      format.atom
    end  
  end
end
