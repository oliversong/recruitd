class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # def facebook
  #   # You need to implement the method below in your model
  #   @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
  # 
  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.facebook_data"] = env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  
  # def linked_in
  #   puts "LINKEDIN FFFFFFUUUUUU\n\n"
  #   puts "#{params.to_yaml}"
  #   
  #   @user = User.find_for_linkedin_oauth(env["omniauth.auth"], current_user)
  # 
  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.facebook_data"] = env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  
  def method_missing(provider)
    
    if !User.omniauth_providers.index(provider).nil?
      #omniauth = request.env["omniauth.auth"]
      omniauth = env["omniauth.auth"]
      
      #puts "#{env["omniauth.auth"].to_yaml}"
    
      if current_user #or User.find_by_email(auth.recursive_find_by_key("email"))
        # current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
        
        current_user.apply_omniauth(omniauth)
        flash[:notice] = "Authentication successful"
        redirect_to edit_user_registration_path
      else
    
        authentication = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
   
        if authentication
          puts "found authentication"
          
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          puts authentication.to_yaml
          
          sign_in(authentication.user)
          redirect_to home_path
          #sign_in_and_redirect(authentication.user, :event => :authentication)
        else
          puts "did not find authentication"
          #create a new user
          
          # puts omniauth.to_yaml
          
          unless omniauth.recursive_find_by_key("email").blank?
            user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
            user.load_from_facebook(omniauth)
            
            # if current_subdomain == "hiring"
            #   user.type = "Recruiter"
            # else
              user.type = "Student"
            # end
            
          else
            #user = User.new
            User.create_userless_omniauth(omniauth)
            redirect_to from_linkedin_authentications_path(:uid => omniauth['uid']) and return
          end
          
          user.apply_omniauth(omniauth)
          #user.confirm! #unless user.email.blank?
          
          if user.save
            puts "user successfully saved"
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider'] 
            
            if(provider == :facebook)
              sign_in(:user, user)
              redirect_to from_facebook_authentications_path and return
            else
              sign_in_and_redirect(:user, user)
            end
          else
            session[:omniauth] = omniauth.except('extra')
            redirect_to new_user_registration_url
          end
        end
      end
    end
  end
  
end