class AuthenticationsController < ApplicationController
  def newly_created
  end
  
  def from_linkedin
    @uid = params[:uid]
    @user = User.new(:first_name => params[:first_name], :last_name => params[:last_name])
  end
  
  def add_details
    @user = current_user
    @careers = Career.all
  end
  
  def finalize_linkedin
    user = User.find_by_email(params[:user][:email])
    if(user)
      flash[:notice] = "This email already belongs to an existing account.  Please log in with this email before adding your Linkedin account."
      redirect_to new_user_session_path and return
    end
    
    #if current_subdomain == "hiring"
      # user = Recruiter.new(params[:user])
    # else
          user = Student.new(params[:user])
    #     end
    
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
      begin
        current_user.import_linkedin_xml(response.body)
      rescue
      end
      
    end
    
    #give 20 friends
    User.all.sort_by{rand}[0..20].each do |user|
      Factory(:following, :follower => current_user, :followed => user)
    end
    
    #give some newsfeed items
    current_user.users_followed.each do |user|
      if rand > 0.5
        update = Factory(:update, :user => user)
        user.post_update(update)
      end
    end
    
    # give some labels
    3.times do
      #add some labels
      label = Factory(:student_label, :owner => current_user)
    
      Company.all.sort_by{rand}[0..3].each do |company|
        Factory(:student_labeling, :student => current_user, :label => label, :applyable => company)
      end
    
      Job.all.sort_by{rand}[0..1].each do |job|
        Factory(:student_labeling, :student => current_user, :label => label, :applyable => job)
      end
    end
    
    
    redirect_to home_path
    
    #sign_in_and_redirect(:user, user, :redirect_to => home_path)
  end
  
  def finalize
    current_user.update_attributes(params[:user])
    current_user.type = "Student"
    current_user.save
    
    #give 20 friends
    User.all.sort_by{rand}[0..20].each do |user|
      Factory(:following, :follower => current_user, :followed => user)
    end
    
    #give some newsfeed items
    current_user.users_followed.each do |user|
      if rand > 0.5
        update = Factory(:update, :user => user)
        user.post_update(update)
      end
    end
    
    # give some labels
    3.times do
      #add some labels
      label = Factory(:student_label, :owner => current_user)
    
      Company.all.sort_by{rand}[0..3].each do |company|
        Factory(:student_labeling, :student => current_user, :label => label, :applyable => company)
      end
    
      Job.all.sort_by{rand}[0..1].each do |job|
        Factory(:student_labeling, :student => current_user, :label => label, :applyable => job)
      end
    end
    
    
    redirect_to home_path
    
    #sign_in_and_redirect(:user, user, :redirect_to => home_path)
  end
end
