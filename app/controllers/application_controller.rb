class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :authenticate_user

  private

  def authenticate_user
    redirect_to login_path unless session[:user_id]
  end
end
