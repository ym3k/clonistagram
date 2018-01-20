class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :set_login, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    puts "hello!!"
    puts avatar_params
    @user.update(avatar_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :avatar)
  end
  
  def avatar_params
    params.require(:user).permit(:avatar, :remove_avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def set_login
    if !logged_in?
      redirect_to new_session_path
    end
  end
end
