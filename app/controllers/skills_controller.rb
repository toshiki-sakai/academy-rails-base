class SkillsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_dates, only: [:new, :edit, :update]
  before_action :initialize_learning_data, only: [:new, :edit]
  before_action :set_month_data, only: [:new, :edit, :update]
  before_action :set_month_time, only: [:new, :edit, :update]

  def new
    @learning_data = @user.learning_data.new
  end

  def create
    binding.pry
    @learning_data = @user.learning_data.new(learning_data_params)
    if @learning_data.save
      redirect_to edit_user_skill_path(@user, month_data, month: params[:month])
    else
      render :new
    end
  end

  def edit
  end

  def update
    selected_month = params[:month].present? ? params[:month] : @current_month
    month_data = nil

    case selected_month
    when @current_month
      month_data = @current_month_data.first
    when @last_month
      month_data = @last_month_data.first
    when @two_months_ago
      month_data = @two_months_ago_data.first
    else
      flash[:error] = "無効な月の選択です。"
      render :edit and return
    end

    if month_data.update(learning_data_params)
      redirect_to edit_user_skill_path(@user, month_data, month: params[:month]), notice: 'データが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_dates
    @current_month = Date.today.strftime("%Y-%m")
    @last_month = (Date.today - 1.month).strftime("%Y-%m")
    @two_months_ago = (Date.today - 2.months).strftime("%Y-%m")
  end

  def initialize_learning_data
    # デフォルトのカテゴリIDを確認し、存在しない場合は作成
    default_category = Category.find_or_create_by!(id: 1) do |category|
      category.name = "Default Category"
    end

    # 各月の学習データが存在しない場合、デフォルトのデータを作成
    [@current_month, @last_month, @two_months_ago].each do |month|
      unless @user.learning_data.exists?(month: month)
        @user.learning_data.create!(
          month: month,
          time: 0,
          skill: "Default skill",
          category_id: default_category.id
        )
      end
    end
  end

  def set_month_data
    # 月に紐づいたユーザーの学習データ
    @current_month_data = @user.learning_data.where(month: @current_month)
    @last_month_data = @user.learning_data.where(month: @last_month)
    @two_months_ago_data = @user.learning_data.where(month: @two_months_ago)
  end

  def set_month_time
    # 月に紐づいた学習時間
    @current_month_time = @current_month_data.order(updated_at: :desc).pluck(:time).first
    @last_month_time = @last_month_data.order(updated_at: :desc).pluck(:time).first
    @two_months_ago_time = @two_months_ago_data.order(updated_at: :desc).pluck(:time).first
  end

  def learning_data_params
    params.require(:learning_data).permit(:category_id, :skill, :time, :month)
  end
end
