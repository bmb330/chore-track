require 'acceptance_helper'

RSpec.resource "Categories" do
  header "Context-Type", "application/json"

  shared_context "category parameters" do
    parameter :name,
      "Category name",
      required: true,
      scope: :category
  end

  shared_context "persisted category" do
    parameter :id,
      "Category id",
      required: true

    let(:persisted_category) { FactoryGirl.create :category }
    let(:category_id) { persisted_category.id }
  end

  get "/categories" do
    FactoryGirl.build :category, name: 'First category'
    FactoryGirl.build :category, name: 'Second category'

    example_request "Get a list of categories" do
      categories = JSON.parse response_body
      expect(categories["categories"].count).to eq 2
      expect(status).to eq 200
    end
  end

  get "/categories/:category_id" do
    include_context "persisted category"

    example_request "Get a specific category" do
      category = JSON.parse response_body
      expect(category["category"]["id"]).to eq category_id
      expect(status).to eq 200
    end
  end

  post "/categories" do
    include_context "category parameters"

    let(:name) { "New Category" }
    
    example_request "Create a category" do
      category = JSON.parse response_body
      expect(category["category"]["name"]).to eq name
      expect(status).to eq 201
    end
  end

  patch "/categories/:category_id" do
    include_context "persisted category"
    include_context "category parameters"

    let(:name) { "Updated Category" }

    example_request "Update a category" do
      category = JSON.parse response_body
      expect(category["category"]["name"]).to eq name
      expect(status).to eq 200
    end
  end

  delete "/categories/:category_id" do
    include_context "persisted category"

    example_request "Delete a category" do
      expect(status).to eq(204)
    end
  end
end
