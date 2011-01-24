class User < ActiveRecord::Base
  
  TABS = {"HOME" => 0, "PUBLIC" => 1, "MANAGE" => 2, "BROWSE" => 3, "SETTINGS" => 4}

  has_many :user_tokens
  
  #paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "172x400", :thumb => "100x100>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :first_name, :last_name

  belongs_to :entity, :polymorphic => true
  
  has_many :updates
  has_many :followings_as_follower, :class_name => "Following", :foreign_key => "follower_id"
  has_many :users_followed, :through => :followings_as_follower, :source => :followed
  
  has_many :followings_as_followed, :class_name => "Following", :foreign_key => "followed_id"
  has_many :followers, :through => :followings_as_followed, :source => :follower
  has_many :newsfeed_items
  
  
  def self.create_userless_omniauth(omniauth)
    unless omniauth['credentials'].blank?
        # user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user_token = UserToken.new(:provider => omniauth['provider'],
                       :uid => omniauth['uid'],
                       :token => omniauth['credentials']['token'],
                       :secret => omniauth['credentials']['secret'])
    else
        user_token = UserToken.new(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    user_token.save
  end
  
  def post_update(update)
    #TODO fill this out
    puts "posted update"
  end
  
  #after_create :create_student
  
  def name
      "#{first_name} #{last_name}"
  end

  def self.new_with_session(params, session)
      super.tap do |user|
          if data = session[:omniauth]
              user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
          end
      end
  end

  def apply_omniauth(omniauth)
      #add some info about the user
      #self.name = omniauth['user_info']['name'] if name.blank?
      #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?

      unless omniauth['credentials'].blank?
          # user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
        user_token = user_tokens.build(:provider => omniauth['provider'],
                         :uid => omniauth['uid'],
                         :token => omniauth['credentials']['token'],
                         :secret => omniauth['credentials']['secret'])
      else
          user_token = user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      end
      user_token.save
  #self.confirm!# unless user.email.blank?
  end

  def password_required?
      (!persisted? || user_tokens.empty? || !password.blank?) && super
  end

  ## Identification helpers
  def is_student?
      type == "Student"
  end

  def is_company?
      type == "Company"
  end

  def is_recruiter?
      type == "Recruiter"
  end

  def is_company_entity?
      (type == "Company") || (type == "Recruiter")
  end
  
  def load_from_facebook(omniauth)
    self.first_name = omniauth.recursive_find_by_key("first_name")
    self.last_name = omniauth.recursive_find_by_key("last_name")
    begin
      self.fun_facts = omniauth["extra"]["user_hash"]["bio"]
    rescue NoMethodError
    end
  end
  
  emits_pfeeds :on => [:post_update] , :for => [:itself , :followers]   # Note: if feed needs to be received by all users , you could use :for => [:all_in_its_class]
  receives_pfeed
  
end
