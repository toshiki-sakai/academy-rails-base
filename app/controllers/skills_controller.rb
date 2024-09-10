class SkillsController < ApplicationController
  before_action :set_user
  before_action :set_dates
  before_action :set_month_data
  before_action :set_month_time
  before_action :set_category
  before_action :set_learning_data, only: [:edit, :new]
  before_action :set_category_id

  def new
    @learning_data = @user.learning_data.new
    @selected_month = params[:month]
  end

  def create
    @learning_data = @user.learning_data.new(learning_data_params)

    if params[:month].present?
      @learning_data.month = params[:month]
    end

    if @learning_data.save
      flash[:notice] = {
        skill_name: @learning_data.skill,
        time: @learning_data.time
      }
      redirect_to edit_user_skill_path(@user, @learning_data), notice: '学習データが追加されました。'
    else
      render :new, status: :unprocessable_entity
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
      redirect_to edit_user_skill_path(@user, month_data, month: params[:month])
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_category
    @category = Category.find_by(id: params[:category_id]) || Category.where(id: [1, 2, 3])
  end

  def set_category_id
    @category_id_1 = Category.find_by(id: 1)
    @category_id_2 = Category.find_by(id: 2)
    @category_id_3 = Category.find_by(id: 3)
  end

  def set_dates
    @current_month = Date.today.strftime("%Y-%m")
    @last_month = (Date.today - 1.month).strftime("%Y-%m")
    @two_months_ago = (Date.today - 2.months).strftime("%Y-%m")
  end

  def set_month_data
    # 月に紐づいたユーザーの学習データ
    @current_month_data = @user.learning_data.where(month: @current_month)
    @last_month_data = @user.learning_data.where(month: @last_month)
    @two_months_ago_data = @user.learning_data.where(month: @two_months_ago)
  end

  def set_month_time
    # 月に紐づいた学習時間
    @current_month_time = @current_month_data.order(updated_at: :desc).pluck(:time).first || 0
    @last_month_time = @last_month_data.order(updated_at: :desc).pluck(:time).first || 0
    @two_months_ago_time = @two_months_ago_data.order(updated_at: :desc).pluck(:time).first || 0
  end

  def set_learning_data
    default_skills = {
      1 => 'Ruby',      # id=1
      2 => 'HTML',      # id=2
      3 => 'Heroku'     # id=3
    }

    current_month = params[:month] || @current_month

    [@current_month_data, @last_month_data, @two_months_ago_data].each do |data_set|
      data_set_month = case data_set
                        when @current_month_data
                          @current_month
                        when @last_month_data
                          @last_month
                        when @two_months_ago_data
                          @two_months_ago
                        end

      default_skills.each do |category_id, skill_name|
        unless data_set.where(category_id: category_id).exists?
          data_set.create!(
            user: @user,
            category_id: category_id,
            skill:skill_name,
            time: 0,
            month: data_set_month
          )
        end
      end
    end
  end

  def learning_data_params
    params.require(:learning_data).permit(:user_id, :category_id, :skill, :time, :month)
  end
end
