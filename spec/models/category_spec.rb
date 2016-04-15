require 'rails_helper'

RSpec.describe Category, :type => :model do
  it { is_expected.to have_attribute :name }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many(:chores).dependent(:destroy) }
end
