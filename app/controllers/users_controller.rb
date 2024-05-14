class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  skip_before_action :authenticate_user, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    if @user.save
        redirect_to login_path, notice: "アカウントを作成しました。"
    else
        render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
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
