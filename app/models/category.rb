class Category < ApplicationRecord
  has_many :learning_datum

  validates :name, presence: true
end
