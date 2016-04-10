class Chore < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :category_id
  validates :category_id, presence: true
end
