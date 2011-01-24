class InfoController < ApplicationController
  
  def home
    if current_user
      if current_user.is_student?
        student_home
      elsif current_user.is_company_entity?
        company_home
      else
        render "newly_created"
        #redirect_to "/users/sign_in"
      end
    else
      if current_subdomain == "hiring"
        render "info/frontpage_recruiter", :layout => "public"
      else
        render "info/frontpage_student", :layout => "public"
      end
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
        company_settings
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
    
    @company_file = CompanyFile.by_company_id(@recruiter.company_id).offset(@page).limit(1).find(:first)
    
    render 'c/browse'
  end
  
  
  #############
  # STUDENT
  #############
  
  def student_manage
    @student = current_user.becomes(Student)
    
    @student_labelings = StudentLabeling.find(:all, :conditions => ["student_id = ?", current_user.id], :include => [:student_file, :applyable])
    
    render 's/manage'
  end
  

  def student_home
    @student = current_user.becomes(Student)
    render 's/home'
  end
  
  def student_browse
    @page = params[:page] ? [Integer(params[:page]), 0].max : 0
    
    #@student = current_user.entity
    
    @student_file = StudentFile.by_student_id(current_user.id).offset(@page).limit(1).find(:first)
    
    render 's/browse'
  end
  
  def student_settings
    render 's/settings'
  end
  
  def newly_created
  end
  
  def from_linkedin
    @uid = params[:uid]
    @user = User.new(:first_name => params[:first_name], :last_name => params[:last_name])
  end
  
  def finalize_user
    user = User.find_by_email(params[:user][:email])
    if(user)
      flash[:notice] = "This email already belongs to an existing account.  Please log in with this email before adding your Linkedin account."
      redirect_to new_user_session_path and return
    end
    
    if current_subdomain == "hiring"
      user = Recruiter.new(params[:user])
    else
      user = Student.new(params[:user])
    end
    
    token = UserToken.find_by_uid(params[:uid])
    
    user.user_tokens << token
    
    user.save
    
    sign_in(:user, user)
    
    if current_user.is_student?
      #import linkedin
      def prepare_access_token(oauth_token, oauth_token_secret)
          consumer = OAuth::Consumer.new(APP_CONFIG["linkedin"]["api_key"], 
              APP_CONFIG["linkedin"]["api_secret"],
              { :site => "https://api.linkedin.com/uas/oauth/accessToken"
              })
          # now create the access token object from passed values
          token_hash = { :oauth_token => oauth_token,
                          :oauth_token_secret => oauth_token_secret
                       }
          access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
          return access_token
      end
    
      auth = current_user.user_tokens.find(:first, :conditions => { :provider => 'linked_in' })
    
      # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
      access_token = prepare_access_token(auth['token'], auth['secret'])
    
      # use the access token as an agent to get the home timeline
      response = access_token.request(:get, "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,headline,location:(name),summary,honors,interests,positions,publications,patents,languages,skills,educations,phone-numbers,main-address)")
    
      current_user.import_linkedin_xml(response.body)
      
    end
    
    redirect_to home_path
    
    #sign_in_and_redirect(:user, user, :redirect_to => home_path)
  end
end
