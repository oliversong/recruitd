class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :layout
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end
  
  def stored_location_for(resource)
    if current_user && params[:redirect_to]
      flash[:notice] = "Congratulations, you're signed up!"
      return params[:redirect_to]
    end
    super( resource ) 
  end
  
end


