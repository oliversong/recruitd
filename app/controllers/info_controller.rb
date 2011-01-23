class InfoController < ApplicationController
  
  def home
    if current_user
      if current_user.is_student?
        student_home
      elsif current_user.is_company_entity?
        company_home
      else
        render "info/home_no_login", :layout => "public"
        #redirect_to "/users/sign_in"
      end
    else
      render "info/home_no_login", :layout => "public"
    end
  end
  
  def browse
    if current_user
      if current_user.is_student?
        student_browse
      elsif current_user.is_company_entity?
        company_browse
      else
        render "info/home_no_login"
        #redirect_to "/users/sign_in"
      end
    else
      render "info/home_no_login", :layout => false
    end
  end
  
  def manage
    if current_user
      if current_user.is_student?
        student_manage
      elsif current_user.is_company_entity?
        company_manage
      else
        render "info/home_no_login"
        #redirect_to "/users/sign_in"
      end
    else
      render "info/home_no_login", :layout => false
    end
  end
  
  def settings
    if current_user
      if current_user.is_student?
        student_settings
      elsif current_user.is_company_entity?
        company_setting
      else
        render "info/home_no_login"
        #redirect_to "/users/sign_in"
      end
    else
      render "info/home_no_login", :layout => false
    end
  end
  
  def public
    if current_user
      if current_user.is_student?
        redirect_to current_user.becomes(Student)
      else
        redirect_to current_user.becomes(Recruiter)
      end
    else
      render "info/home_no_login", :layout => false
    end
  end
  
  def updates
  end
  
  ##############
  # COMPANY
  ##############
  
  def company_manage
    @company = current_user.company
    @company_files = @company.company_files
    
    @starred_company_files = @company_files.select{|company_file| company_file.starred }
    render 'c/manage'
  end
  

  def company_home
    @recruiter = current_user.becomes(Recruiter)
    @company = @recruiter.company

    render "c/home"
  end
  
  def company_settings
    @recruiter = current_user.becomes(Recruiter)
    @company = @recruiter.company
    
    render "c/settings"
  end
  
  def company_update_settings
    @recruiter = current_user.becomes(Recruiter)
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
  
  def company_browse
    @page = params[:page] ? [Integer(params[:page]), 0].max : 0
    
    @recruiter = current_user.becomes(Recruiter)
    
    @company_feed = CompanyFeed.by_company_id(@recruiter.company_id).offset(@page).limit(1).find(:first)
    
    @company_file = CompanyFile.find_or_initialize_by_company_id_and_student_id(@recruiter.company_id, @company_feed.student_id)
    
    render 'c/browse'
  end
  
  
  #############
  # STUDENT
  #############
  
  def student_manage
    @student = current_user.becomes(Student)
    
    @student_files = @student.student_files    
    @starred_student_files = @student_files.select{|student_file| student_file.starred }
    
    render 's/manage'
  end
  

  def student_home
    @student = current_user.becomes(Student)
    
    render 's/home'
  end
  
  def student_browse
    @page = params[:page] ? [Integer(params[:page]), 0].max : 0
    
    #@student = current_user.entity
    
    @student_feed = StudentFeed.by_student_id(current_user.id).offset(@page).limit(1).find(:first)
    
    if @student_feed.company_id
      #@followed = !!Following.find_by_follower_id_and_followed_id( current_user.id, @student_feed.company.user_id)
      @student_file = StudentFile.find_or_initialize_by_student_id_and_company_id( current_user.id, @student_feed.company_id)
    elsif @student_feed.job_id
      @student_file = StudentFile.find_or_initialize_by_student_id_and_job_id( current_user.id, @student_feed.job_id)
    end
    
    render 's/browse'
  end
  
  def student_settings
    render 's/settings'
  end
  
end
