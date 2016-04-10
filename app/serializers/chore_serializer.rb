class ChoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :completed
  has_one :category
end
