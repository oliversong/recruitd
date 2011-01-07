class PeopleController < ApplicationController
  
  skip_before_filter :require_activation, :only => :verify_email
  skip_before_filter :admin_warning, :only => [ :show, :update ]
  before_filter :login_required, :only => [ :show, :edit, :update,
                                            :common_contacts ]
  before_filter :correct_user_required, :only => [ :edit, :update ]
  before_filter :setup
  
  def index
    @users = User.mostly_active(params[:page])

    respond_to do |format|
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
    unless @user.active? or current_user.admin?
      flash[:error] = "That user is not active"
      redirect_to home_url and return
    end
    if logged_in?
      @some_contacts = @user.some_contacts
      page = params[:page]
      @common_contacts = current_user.common_contacts_with(@user,
                                                             :page => page)
      # Use the same max number as in basic contacts list.
      num_contacts = User::MAX_DEFAULT_CONTACTS
      @some_common_contacts = @common_contacts[0...num_contacts]
      @blog = @user.blog
      @posts = @user.blog.posts.paginate(:page => params[:page])
      @galleries = @user.galleries.paginate(:page => params[:page])
    end
    respond_to do |format|
      format.html
    end
  end

  def new
    @body = "register single-col"
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    respond_to do |format|
      @user.email_verified = false if global_prefs.email_verifications?
      @user.identity_url = session[:verified_identity_url]
      @user.save
      if @user.errors.empty?
        session[:verified_identity_url] = nil
        if global_prefs.email_verifications?
          @user.email_verifications.create
          flash[:notice] = %(Thanks for signing up! Check your email
                             to activate your account.)
          format.html { redirect_to(home_url) }
        else
          self.current_user = @user
          flash[:notice] = "Thanks for signing up!"
          format.html { redirect_back_or_default(home_url) }
        end
      else
        @body = "register single-col"
        format.html { if @user.identity_url.blank? 
                        render :action => 'new'
                      else
                        render :partial => "shared/useral_details.html.erb", :object => @user, :layout => 'application'
                      end
                    }
      end
    end
  rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to home_url
  rescue ActionController::InvalidAuthenticityToken
    # Experience has shown that the vast majority of these are bots
    # trying to spam the system, so catch & log the exception.
    warning = "ActionController::InvalidAuthenticityToken: #{params.inspect}"
    logger.warn warning
    redirect_to home_url
  end

  def verify_email
    verification = EmailVerification.find_by_code(params[:id])
    if verification.nil?
      flash[:error] = "Invalid email verification code"
      redirect_to home_url
    else
      cookies.delete :auth_token
      user = verification.user
      user.email_verified = true; user.save!
      self.current_user = user
      flash[:success] = "Email verified. Your profile is active!"
      redirect_to user
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      case params[:type]
      when 'info_edit'
        if !preview? and @user.update_attributes(params[:user])
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(@user) }
        else
          if preview?
            @preview = @user.description = params[:user][:description]
          end
          format.html { render :action => "edit" }
        end
      when 'password_edit'
        if @user.change_password?(params[:user])
          flash[:success] = 'Password changed.'
          format.html { redirect_to(@user) }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  def common_contacts
    @user = User.find(params[:id])
    @common_contacts = @user.common_contacts_with(current_user,
                                                    :page => params[:page])
    respond_to do |format|
      format.html
    end
  end
  
  private

    def setup
      @body = "user"
    end
  
    def correct_user_required
      redirect_to home_url unless User.find(params[:id]) == current_user
    end
    
    def preview?
      params["commit"] == "Preview"
    end
end
