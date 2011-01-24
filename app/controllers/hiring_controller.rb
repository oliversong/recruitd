class HiringController < ApplicationController
  def home
    if current_user
      if current_user.is_student?
        student_home
      elsif current_user.is_company_entity?
        company_home
      else
        render "registrations/newly_created"
        #redirect_to "/users/sign_in"
      end
    else
      render "hiring/home_no_login", :layout => "public"
    end
  end
end
