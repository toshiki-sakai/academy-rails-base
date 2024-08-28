class Category < ApplicationRecord
  has_many :learning_data, class_name: 'LearningData'

  # validates :name, presence: true
end
