class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
