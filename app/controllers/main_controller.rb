class MainController < ApplicationController
  def index
    if logged_in?
      @user = current_user
    else
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :email, :password, :password_confirmation, :content, :image)
  end
end
