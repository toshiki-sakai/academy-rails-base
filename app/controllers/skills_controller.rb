class SkillsController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @current_month = Date.today.month
    @categories = Category.all
    @learning_data = LearningDatum.where(user: @user, month: @current_month)
  end

  def create_learning_data
    @learning_data = LearningDatum.new(learning_data_params)
    @learning_data.user = current_user

    if @learning_data.save
      render json: { success: true, message: '学習時間が保存されました。' }
    else
      render json: { success: false, errors: @learning_data.errors.full_messages }
    end
  end

  private

    def learning_data_params
      params.require(:learning_datum).permit(:category_id, :skill, :time, :month)
    end
end
