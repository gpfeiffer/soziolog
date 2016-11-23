class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new # guest user (not logged in)
    return if !user

    if user.admin?
      can :manage, :all
    elsif user.auditor?
      can :read, :all
    else
      can :read, Conference
    end
  end
end
