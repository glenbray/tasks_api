require "rails_helper"

RSpec.describe "Tasks API", type: :request do
  describe "GET /api/tasks" do
    it "returns a successful response" do
      get "/api/tasks"
      expect(response).to have_http_status(:success)
    end
  end
end
