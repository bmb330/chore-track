require 'rails_helper'

RSpec.describe Category, :type => :model do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
  end

  describe "validations" do
    it "has a name" do
      subject.name = nil
      subject.valid?
      expect(subject.errors[:name]).to include "can't be blank"
    end

    it "has a unique name" do
      original = FactoryGirl.create(:category)
      duplicate = FactoryGirl.build(:category, name: original.name)
      duplicate.valid?
      expect(duplicate.errors[:name]).to include "has already been taken"
    end
  end
end
