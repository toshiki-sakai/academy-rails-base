class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :set_learning_datum, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to login_path
    else
        render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      Rails.logger.info(@user.errors.full_messages)
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :image, :introduction)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      unless @user.id == session[:user_id]
        redirect_to root_path
      end
    end

    def set_learning_datum
      @learning_data = LearningDatum.find(params[:id])
    end

    def set_learning_datum
      @learning_data = LearningDatum.find(params[:id])
    end
end
