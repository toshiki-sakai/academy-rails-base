class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user=User.find_by(email: session_params[:email])
      if user&.authenticate(session_params[:password])
      session[:user_id]=user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_url, notice: "ログアウトしました。"
  end
end