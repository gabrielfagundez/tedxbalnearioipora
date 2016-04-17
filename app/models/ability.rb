class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :admin
      can :manage, :projects
      can :manage, :team_members
      can :manage, :project_sensitive_data

    elsif user.client_manager?
      cannot :manage, :admin
      can :manage, :projects
      can :manage, :team_members
      can :manage, :project_sensitive_data

    elsif user.team_member?
      cannot :manage, :admin
      cannot :manage, :projects
      cannot :manage, :team_members
      cannot :manage, :project_sensitive_data
    end

  end
end
