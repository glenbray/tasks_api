require "swagger_helper"

RSpec.describe "Tasks API", swagger_doc: "v1/swagger.yaml", type: :request do
  path "/api/tasks" do
    get("Lists all tasks") do
      tags "Tasks"
      produces "application/json"

      response "200", "Tasks list" do
        schema type: :array, items: { type: :object } # Basic schema, update when controller returns data
        run_test! do |response|
          # This block can be used for verification specific to documentation generation if needed
          # For now, we rely on the integration test for functional verification.
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
