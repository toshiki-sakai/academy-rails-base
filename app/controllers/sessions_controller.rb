class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:email].blank? && params[:session][:password].blank?
      render :new, status: :unprocessable_entity
    else
      @user= User.find_by(email: params[:session][:email].downcase)
      if @user&.authenticate(params[:session][:password])
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path
      else
      flash[:danger] = 'メールアドレス、もしくはパスワードが間違っています'
      render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_url, notice: "ログアウトしました。"
  end
end