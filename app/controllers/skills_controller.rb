class SkillsController < ApplicationController
  before_action :set_user
  before_action :set_learning_datum, only: [:edit, :update]

  def edit
    @current_month = Date.today.month
    @categories = Category.all
    @learning_data = LearningDatum.where(user: @user, month: @current_month).first
  end

  def create
    @learning_data = LearningDatum.new(learning_data_params)
    @learning_data.user = @user

    if @learning_data.save
      render json: { success: true, message: '学習時間が保存されました。' }
    else
      render json: { success: false, errors: @learning_data.errors.full_messages }
    end
  end

  def update
    if @learning_data.update(learning_data_params)
      redirect_to edit_user_skill_path(@user, @learning_data), notice: '学習時間が更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_learning_datum
    @learning_data = LearningDatum.find(params[:id])
  end

  def learning_data_params
    params.require(:learning_datum).permit(:category_id, :skill, :time, :month)
  end
end
