class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:session][:email].blank? && params[:session][:password].blank?
      flash[:danger] = 'メールアドレスとパスワードを入力してください'
      render :new, status: :unprocessable_entity
    else
      @user= User.find_by(email: params[:session][:email].downcase)
      if @user&.authenticate(params[:session][:password])
        reset_session
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:danger] = 'メールアドレス、もしくはパスワードが間違っています'
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    reset_session
    session.delete(:user_id)
    redirect_to logout_path, notice: "ログアウトしました。"
  end
end