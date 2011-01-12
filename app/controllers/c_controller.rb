class CController < ApplicationController
  def manage
    if !current_user.is_recruiter?
      redirect_to :new_user_session
    end
    
    @company = current_user.entity.company
    @company_files = @company.company_files
  end
  

  def home
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    
    @recruiter = current_user.entity
    @company = @recruiter.company
  end
  
  
end
