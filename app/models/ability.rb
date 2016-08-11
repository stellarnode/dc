class Ability
  include CanCan::Ability

  def initialize(user)
    # You can  make the scope of actions like this
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    # user ||= User.new # for guest user (not logged in)
    if user.has_role? :admin
        can :manage, :all
    end
    if user.has_role? :user
        can :read, :all
        can [:create, :update, :destroy], Post, :user => user
        can [:create, :update, :destroy], Poll, :user => user
        # cannot :voting, Poll do |poll| 
        #     poll.votes.pluck(:user_id).include? user.id
        # end
    end
    if user.has_role? :moderator
        can :crud, :all
    end
  end
end
