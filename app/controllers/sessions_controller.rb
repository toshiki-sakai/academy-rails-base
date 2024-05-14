class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
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
        @user = User.new(session_params)
        flash[:danger] = 'メールアドレス、もしくはパスワードが間違っています'
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    reset_session
    session.delete(:user_id)
    redirect_to logout_url, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password_digest)
  end
end