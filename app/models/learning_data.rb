class LearningData < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :skill, presence: true
  validates :time, presence: true
  validates :month, presence: true
end
