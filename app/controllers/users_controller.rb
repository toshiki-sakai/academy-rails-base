class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_dates, only: [:show]
  before_action :set_time_totals, only: [:show]
  before_action :chart_data, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def update_user_params
    params.require(:user).permit(:avatar, :image, :introduction)
  end

  def set_user
    @user = current_user
    redirect_to root_path if @user.nil?
  end

  def set_dates
    @current_month = Date.today.strftime("%Y-%m")
    @last_month = (Date.today - 1.month).strftime("%Y-%m")
    @two_months_ago = (Date.today - 2.months).strftime("%Y-%m")
  end

  def set_time_totals
    months = [@two_months_ago, @last_month, @current_month]
    learning_data = LearningDatum.where(user: @user, month: months)
    totals = learning_data.joins(:category).group('learning_data.month', 'categories.name').sum(:time)
    @totals_by_month_and_category = {}
    totals.each do |(month, category_name), total_time|
      @totals_by_month_and_category[month] ||= {}
      @totals_by_month_and_category[month][category_name] = total_time
    end
  end

  def chart_data
    categories = {
      backend: 'バックエンド',
      frontend: 'フロントエンド',
      infra: 'インフラ'
    }

    months = [@two_months_ago, @last_month, @current_month]
    @learning_data = {}

    categories.each do |key, category_name|
      totals = months.map do |month|
        @totals_by_month_and_category.dig(month, category_name) || 0
      end
      @learning_data[key] = totals
    end
  end
end
