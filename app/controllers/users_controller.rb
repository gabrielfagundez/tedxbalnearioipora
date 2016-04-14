class UsersController < ApplicationController

  before_filter :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @clients = Client.all
  end

  def create
    @user = User.new(user_params.merge(password: params[:user][:password]))
    if @user.save
      params[:clients].each do |client_id|
        @user.clients << Client.find(client_id)
      end
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @clients = Client.all
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
    @user = User.find(params[:id])
  end

end
