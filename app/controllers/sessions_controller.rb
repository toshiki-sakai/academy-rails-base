class SessionsController < ApplicationController
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
        redirect_to root_path
      else
        @user = User.new(session_params)
        flash[:danger] = 'メールアドレス、もしくはパスワードが間違っています'
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_url, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end