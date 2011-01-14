class InfoController < ApplicationController
  def home
    if current_user
      if current_user.is_student?
        redirect_to home_s_path
      else
        redirect_to home_c_path
      end
    else
      redirect_to "devise/sessions#new"
    end
  end
  
  def updates
  end
end
