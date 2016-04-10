class Category < ApplicationRecord
  has_many :chores, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
