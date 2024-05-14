class SkillController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password, :password_confirmation, :image)
    end
end
