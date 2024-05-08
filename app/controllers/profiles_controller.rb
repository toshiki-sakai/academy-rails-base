class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.avatar.attach(params[:user][:avatar])
    if @user.update(user_params)
      flash[:notice] = "プロフィールが変更されました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password, :password_confirmation)
    end
end
