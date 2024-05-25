class SkillsController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @current_month = Date.today.month
    @skills = Skill.where(user: @user, month: @current_month)
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password, :password_confirmation, :image)
    end
end
