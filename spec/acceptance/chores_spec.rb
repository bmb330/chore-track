require 'acceptance_helper'

RSpec.resource "Chores" do
  header "Accept", "application/json"
  header "Context-Type", "application/json"

  shared_context "chore parameters" do
    parameter :name,
      "Chore name",
      required: true,
      scope: :chore

    parameter :category_id,
      "Category id",
      required: true,
      scope: :chore

    parameter :description,
      "Chore description",
      scope: :chore
  end

  shared_context "persisted chore" do
    parameter :id,
      "Chore id",
      required: true

    let(:persisted_chore) { FactoryGirl.create :chore }
    let(:chore_id) { persisted_chore.id }
  end

  get "/chores" do
    before do
      FactoryGirl.create :chore, name: 'First chore'
      FactoryGirl.create :chore, name: 'Second chore'
    end

    example_request "Get a list of chores" do
      chores = JSON.parse response_body
      expect(chores["chores"].count).to eq 2
      expect(status).to eq 200
    end
  end

  get "/chores/:chore_id" do
    include_context "persisted chore"

    example_request "Get a specific chore" do
      chore = JSON.parse response_body
      expect(chore["chore"]["id"]).to eq chore_id
      expect(status).to eq 200
    end
  end

  post "/chores" do
    include_context "chore parameters"

    let(:name) { "New Chore" }
    let(:category_id) { FactoryGirl.create(:category).id.to_s }
    
    example_request "Create a chore" do
      chore = JSON.parse response_body
      expect(chore).to eq name
      expect(chore["chore"]["name"]).to eq name
      expect(status).to eq 201
    end
  end

  patch "/chores/:chore_id" do
    include_context "persisted chore"
    include_context "chore parameters"

    let(:name) { "Updated Chore" }

    example_request "Update a chore" do
      chore = JSON.parse response_body
      expect(chore["chore"]["name"]).to eq name
      expect(status).to eq 200
    end
  end

  delete "/chores/:chore_id" do
    include_context "persisted chore"

    example_request "Delete a chore" do
      expect(status).to eq(204)
    end
  end
end
