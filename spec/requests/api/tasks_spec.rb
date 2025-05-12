require "rails_helper"

RSpec.describe "Tasks API", type: :request do
  describe "GET /api/tasks" do
    it "returns a successful response" do
      get "/api/tasks"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/tasks" do
    context "with valid parameters" do
      let(:valid_attributes) { {task: {title: "Test"}} }

      it "creates a new Task" do
        expect {
          post "/api/tasks", params: valid_attributes, as: :json
        }.to change(Task, :count).by(1)
      end

      it "returns a created status" do
        post "/api/tasks", params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
      end

      it "returns the created task" do
        post "/api/tasks", params: valid_attributes, as: :json
        json_response = JSON.parse(response.body)
        expect(json_response["title"]).to eq("Test")
        expect(json_response["id"]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { {task: {title: nil}} }

      it "does not create a new Task" do
        expect {
          post "/api/tasks", params: invalid_attributes, as: :json
        }.to change(Task, :count).by(0)
      end

      it "returns an unprocessable entity status" do
        post "/api/tasks", params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a JSON response with errors" do
        post "/api/tasks", params: invalid_attributes, as: :json
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Title can't be blank")
      end
    end
  end
end
