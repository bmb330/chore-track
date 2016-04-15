require 'rails_helper'

RSpec.describe Chore, :type => :model do
  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :description }
  it { is_expected.to have_attribute :completed }
  it { is_expected.to have_attribute :category_id }

  it { should belong_to(:category) }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:category_id) }
end
