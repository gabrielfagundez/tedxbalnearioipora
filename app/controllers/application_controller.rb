class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_favorite_projects

  layout :layout_by_resource

  def current_account
    @current_account ||= current_user.account
  end

  def set_favorite_projects
    if current_user.present?
      @favorite_projects = current_user.favorite_projects.collect(&:project)
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

end
