class SkillsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :set_dates, only: [:edit, :update]
  before_action :set_learning_data, only: [:edit, :update]
  before_action :set_month_data, only: [:edit, :update]

  def edit
  end

  def create
    @learning_data = @user.learning_data.new(learning_data_params)
    @learning_data.user = @user

    if @learning_data.save
      render json: { success: true, message: '学習時間が保存されました。' }
    else
      render json: { success: false, errors: @learning_data.errors.full_messages }
    end
  end

  def update
    if @learning_data.update(learning_data_params)
      redirect_to edit_user_skill_path
    else
      @selected_month = selected_month
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_dates
    # 選択した月
    @selected_month = params[:month] ? params[:month].to_i : @current_month
    # 今月
    @current_month = Date.today.month
    # 先月
    @last_month = (Date.today - 1.month).month
    # 先々月
    @two_months_ago = (Date.today - 2.months).month
  end

  def set_learning_data
    # 単一の学習時間
    # @learning_data = @user.learning_data.where(month: @selected_month)
  end

  def set_learning_data
    # 選択した月に紐づいた学習時間
    @learning_data = @user.learning_data.find(params[:id])
  end

  def set_month_data
    # 当月に基づいたユーザーの学習時間
    @current_month_data = @user.learning_data.where(month: @current_month)
    # 先月に基づいたユーザーの学習時間
    @last_month_data = @user.learning_data.where(month: @last_month)
    # 先々月に基づいたユーザーの学習時間
    @two_months_ago_data = @user.learning_data.where(month: @two_months_ago)
  end

  def learning_data_params
    params.require(:learning_data).permit(:category_id, :skill, :time, :month)
  end
end
