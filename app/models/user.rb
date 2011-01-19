class User < ActiveRecord::Base
  
    has_many :user_tokens
    
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me

    belongs_to :entity, :polymorphic => true
    
    has_many :updates
    has_many :followings_as_follower, :class_name => "Following", :foreign_key => "follower_id"
    has_many :users_followed, :through => :followings_as_follower, :source => :followed
    
    has_many :followings_as_followed, :class_name => "Following", :foreign_key => "followed_id"
    has_many :followers, :through => :followings_as_followed, :source => :follower
    has_many :newsfeed_items
    
    after_create :create_student
    
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
        (user_tokens.empty? || !password.blank?) && super
    end

    ## Identification helpers
    def is_student?
        entity_type == "Student"
    end

    def is_company?
        entity_type == "Company"
    end

    def is_recruiter?
        entity_type == "Recruiter"
    end

    def is_company_entity?
        (entity_type == "Company") || (entity_type == "Recruiter")
    end
    
    def create_student
      s = Student.new(:user => self)
      s.save
      self.entity = s
      self.save
    end
end
