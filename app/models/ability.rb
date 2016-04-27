class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.beta?
      can :manage, :beta
      can :manage, :admin
      can :manage, :projects
      can :manage, :users
      can :manage, :project_sensitive_data

    elsif user.admin?
      can :manage, :admin

      can :manage, :users
      can :manage, :projects
      can :manage, :project_sensitive_data

    elsif user.client_manager?
      cannot :manage, :admin

      can :manage, :users
      can :manage, :projects
      can :manage, :project_sensitive_data

    elsif user.team_member?
      cannot :manage, :admin

      cannot :manage, :users
      cannot :manage, :projects
      cannot :manage, :project_sensitive_data
    end

  end
end
