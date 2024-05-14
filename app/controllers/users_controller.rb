class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  skip_before_action :authenticate_user, only: [:new, :create]

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to login_path
    else
        render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password,
        :password_confirmation, :content, :image, :introduction)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      unless @user.id == session[:user_id]
        redirect_to root_path
      end
    end
end
