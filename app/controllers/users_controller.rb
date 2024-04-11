class UsersController < ApplicationController
  def new
    @user = User.new
    session[:user_id]=@user.id
  end
end
