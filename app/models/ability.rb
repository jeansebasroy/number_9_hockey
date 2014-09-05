class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.admin?
        # provide authorizations for Admins
        can :manage, :all
        can :create, :player
    
    elsif user.id?
        can :show, User, id: user.id
        can :new, User
        can :create, User
        can :update, User, id: user.id

        # need to only allow for Players linked to User
        can :show, Player
        can :edit, Player
        can :update, Player 

        # need to only allow for Coaches linked to User
        #can :show, Coach
        #can :edit, Coach
        #can :update, Coach 

        # need to only allow Camps that are linked Players
        # and / or Coaches linked to User
        can :show, Camp
        #can :register, Camp
        #can :unregister, Camp 

    else
        can :new, User    
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
