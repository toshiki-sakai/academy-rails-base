class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    # session[:user_id]=@user.id
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to root_path, notice: "アカウントを作成しました。"
    else
        render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
