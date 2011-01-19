class InfoController < ApplicationController
  def home
    if current_user
      if current_user.is_student?
        redirect_to home_s_path
      elsif current_user.is_company_entity?
        redirect_to home_c_path
      else
        redirect_to "/users/sign_in"
      end
    else
      redirect_to "/users/sign_in"
    end
  end
  
  def updates
  end
  
end
