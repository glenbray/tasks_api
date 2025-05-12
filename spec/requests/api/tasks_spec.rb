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

      it "creates a task and returns it with status 201" do
        expect {
          post "/api/tasks", params: valid_attributes, as: :json
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response["title"]).to eq("Test")
        expect(json_response["id"]).to be_present
        expect(json_response["created_at"]).to be_present
        expect(json_response["updated_at"]).to be_present
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { {task: {title: nil}} }

      it "does not create a task and returns status 422 with errors" do
        expect {
          post "/api/tasks", params: invalid_attributes, as: :json
        }.to change(Task, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Title can't be blank")
      end
    end
  end

  describe "PATCH /api/tasks/:id/completed" do
    let!(:task) { Task.create!(title: "Complete the task") }

    context "when the task exists" do
      it "marks the task as completed and returns it" do
        expect {
          patch "/api/tasks/#{task.id}/completed", as: :json
        }.to change { task.reload.completed_at }.from(nil)

        expect(response).to have_http_status(:ok)
        expect(task.completed_at).to be_within(1.second).of(Time.current)

        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(task.id)
        expect(json_response["completed_at"]).to be_present
      end
    end

    context "when the task does not exist" do
      it "returns a not found status and error message" do
        patch "/api/tasks/0/completed", as: :json

        expect(response).to have_http_status(:not_found)

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to match(/Task not found/)
      end
    end
  end
end
