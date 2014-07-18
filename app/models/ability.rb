class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new # guest user (not logged in)
    return if !user

    if user.admin?
      can :manage, :all
    else
      can :read, [Conference, Doctorate]
    end
  end
end
