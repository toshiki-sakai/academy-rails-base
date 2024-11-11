class LearningDataController < ApplicationController
  before_action :set_user
  before_action :set_category, only: [:new, :create]
  before_action :set_dates, only: [:new, :edit, :update]
  before_action :set_month_data, only: [:new, :edit, :update]
  before_action :set_month_time, only: [:new, :edit, :update]
  before_action :set_learning_data, only: [:new, :edit, :update]


  def new
    @category = Category.find_by(id: params[:category_id])
    @learning_data = LearningDatum.new(
      category_id: params[:category_id],
      user_id: params[:user_id],
      month: params[:month]
    )
  end

  def create
    @learning_data = @user.learning_datum.new(learning_data_params)
    @learning_data.category = @category

    respond_to do |format|
      if @learning_data.save
        format.turbo_stream
      else
        format.turbo_stream
      end
    end
  end

  def edit
    @categories = Category.all
    @learning_data = LearningDatum.all
  end

  # def update
  #   @learning_data = LearningDatum.find(params[:id])

  #   selected_month = params[:month].present? ? params[:month] : @current_month
  #   month_data = nil

  #   case selected_month
  #   when @current_month
  #     month_data = @current_month_data.first
  #   when @last_month
  #     month_data = @last_month_data.first
  #   when @two_months_ago
  #     month_data = @two_months_ago_data.first
  #   else
  #     flash[:error] = "無効な月の選択です。"
  #     render :edit and return
  #   end

  #   if month_data.update(learning_data_params)
  #     redirect_to edit_user_learning_datum_path(@user, month_data, month: params[:month])
  #   else
  #     render :edit
  #   end
  # end

  def update
    @learning_data = LearningDatum.find(params[:id])

    if @learning_data.update(learning_data_params)
      redirect_to edit_user_learning_datum_path(@user, @learning_data, month: params[:month])
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_dates
    @current_month = Date.today.strftime("%Y-%m")
    @last_month = (Date.today - 1.month).strftime("%Y-%m")
    @two_months_ago = (Date.today - 2.months).strftime("%Y-%m")
  end

  def set_month_data
    # 月に紐づいたユーザーの学習データ
    if @current_month_data.blank?
      @current_month_data = [LearningDatum.create(user: @user, month: @current_month,)]
    end

    if @last_month_data.blank?
      @last_month_data = [LearningDatum.create(user: @user, month: @last_month)]
    end

    if @two_months_ago_data.blank?
      @two_months_ago_data = [LearningDatum.create(user: @user, month: @two_months_ago)]
    end
  end

  def set_month_time
    # 月に紐づいた学習時間
    @current_month_time = @current_month_data.sort_by { |data| data.updated_at }.reverse.pluck(:time).first || 0
    @last_month_time = @last_month_data.sort_by { |data| data.updated_at }.reverse.pluck(:time).first || 0
    @two_months_ago_time = @two_months_ago_data.sort_by { |data| data.updated_at }.reverse.pluck(:time).first || 0
  end

  def set_learning_data
    @learning_data = LearningDatum.find(params[:id]) if params[:id].present?

    default_skills = {
      1 => 'Ruby',      # id=1
      2 => 'HTML',      # id=2
      3 => 'Heroku'     # id=3
    }

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
        # 重複データがあるかどうかを確認して新規作成
        learning_data = LearningDatum.find_or_initialize_by(
          user: @user,
          category_id: category_id,
          skill: skill_name,
          month: data_set_month
        )

        # 既存データでなければ新規作成
        unless learning_data.persisted?
          learning_data.time = 0
          learning_data.save
        end
      end
    end
  end

  def learning_data_params
    params.require(:learning_datum).permit(:skill, :time, :month)
  end
end
