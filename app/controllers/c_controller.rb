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
  
  def settings
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    
    @recruiter = current_user.entity
    @company = @recruiter.company
  end
  
  def update_settings
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    
    @recruiter = current_user.entity
    company_id = @recruiter.company_id
    
    params[:settings].each do |term_id, value|
      if value && !value.empty?
        company_term = CompanyTerm.find_or_create_by_term_id_and_company_id(:term_id => term_id, 
          :company_id => company_id)
        company_term.weight = value
        company_term.save
        puts "#{term_id}: #{value}"
      end
    end
    
    redirect_to settings_c_path
  end
  
  def browse
    if !current_user.is_company_entity?
      redirect_to :new_user_session
    end
    
    idx = params[:id] ? params[:index] : 0
    
    @recruiter = current_user.entity
    
    @company_feed = CompanyFeed.by_company_id(@recruiter.company_id).offset(idx).limit(1).find(:first)
  end
  
end
