class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user=User.find_by(email: session_params[:session][:email].downcase)
    if user&.authenticate(session_params[:session][:password])
      reset_session
      session[:user_id]=user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_url, notice: "ログアウトしました。"
  end
end