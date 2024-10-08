class LearningData < ApplicationRecord
  belongs_to :user
  belongs_to :category

  # 項目名に対するバリデーション
  validates :skill, presence: { message: "項目名は必ず入力してください" },
                    uniqueness: { scope: :month, message: "（%{value}）は既に登録されています" },
                    length: { maximum: 50, message: "項目名は50文字以内で入力してください" }

  # 学習時間に対するバリデーション
  validates :time, presence: { message: "学習時間は必ず入力してください" },
                   numericality: { greater_than_or_equal_to: 0, message: "学習時間は0以上の数字で入力してください" }

  # 月に対するバリデーション
  validates :month, presence: true
end
