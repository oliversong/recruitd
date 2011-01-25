class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    #user ||= User.new # guest user (not logged in)
    if !user
      can [:create, :new], :user
      cannot :manage, :all
    else
      if user.admin
        can :manage, :all
      else
        
        #starting point: can read all, cannot update/destroy any
        can [:create, :read], :all
        cannot [:destroy, :update], :all
        
        # career - can only read
        cannot :create, Career
        
        # club - cannot destroy/update
        
        # course - cannot destroy/update
        
        # department - can only read
        cannot :create, Department
        
        # experience - can do anything; need to check for ownership
        can :manage, Experience
        
        
        if user.is_company_entity?
          # jobs and companies
          can :manage, Job
          can :update, Company
        end
        
        if user.is_student?
          can :update, Student
        end
        
      end
    end

    
  end
end
