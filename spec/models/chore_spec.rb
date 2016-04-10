require 'rails_helper'

RSpec.describe Chore, :type => :model do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :description }
    it { is_expected.to have_attribute :completed }
    it { is_expected.to have_attribute :category_id }
  end

  describe "associations" do
    it "belongs to a category" do
      category = FactoryGirl.create(:category)
      chore = category.chores.build(name: "Associated Chore")
      expect(chore.category).to eq category
    end

    it "is destroyed when category destroyed" do
      category = FactoryGirl.create(:category)
      chore = category.chores.build(name: "Associated Chore")
      category.destroy
      expect(chore.persisted?).to eq false
    end
  end

  describe "validations" do
    it "has a name" do
      subject.name = nil
      subject.valid?
      expect(subject.errors[:name]).to include "can't be blank"
    end

    it "allows same name in different categories" do
      category = FactoryGirl.create(:category)
      other_category = FactoryGirl.create(:category)
      original = FactoryGirl.create(:chore, category: category)
      duplicate = FactoryGirl.build(:chore, name: original.name, category: other_category)
      expect(duplicate.valid?).to eq true
    end

    it "has a unique name in same category" do
      category = FactoryGirl.create(:category)
      original = FactoryGirl.create(:chore, category: category)
      duplicate = FactoryGirl.build(:chore, name: original.name, category: category)
      duplicate.valid?
      expect(duplicate.errors[:name]).to include "has already been taken"
    end

    it "has a category_id" do
      subject.category_id = nil
      subject.valid?
      expect(subject.errors[:category_id]).to include "can't be blank"
    end
  end
end
