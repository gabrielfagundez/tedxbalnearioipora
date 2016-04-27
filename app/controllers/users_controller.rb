class UsersController < ApplicationController

  before_filter :set_user, only: [:edit, :update]
  before_filter :check_auth

  def index
    @users = current_account.users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = current_account.users.new
    @clients = Client.all
  end

  def create
    @user = current_account.users.new(user_params.merge(password: params[:user][:password]))
    if @user.save
      params[:clients].each do |client_id|
        @user.clients << Client.find(client_id)
      end if params[:clients].present?
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @clients = current_account.clients
  end

  def update
    if @user.update_attributes(user_params)
      @user.update_attributes(password: params[:user][:password]) if params[:user][:password].present?
      @user.update_attribute(:clients, [])
      params[:clients].each do |client_id|
        @user.clients << Client.find(client_id)
      end
      redirect_to users_path
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role)
  end

  def set_user
    @user = current_account.users.find(params[:id])
  end

  def check_auth
    redirect_to root_path if cannot? :manage, :users
  end

end
