class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

    def create_user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:avatar, :image, :introduction)
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
