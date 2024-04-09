class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required#全てのアクションを実行する前に、login_requiredメソッドを実行する

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  #ユーザーがログインしていない限り、ログイン画面にレダイレクトする
  end
end
