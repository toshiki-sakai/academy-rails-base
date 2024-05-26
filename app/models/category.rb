class Category < ApplicationRecord
  has_many :learning_data

  validates :name, presence: true
end
