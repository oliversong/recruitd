class AuthenticationsController < ApplicationController
  def newly_created
  end
  
  def from_linkedin
    @uid = params[:uid]
    @user = User.new(:first_name => params[:first_name], :last_name => params[:last_name])
  end
  
  def from_facebook
    @user = current_user
  end
  
  def finalize_linkedin
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
  
  def finalize_facebook
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
