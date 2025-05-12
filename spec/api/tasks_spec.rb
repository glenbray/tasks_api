require "swagger_helper"

RSpec.describe "Tasks API", swagger_doc: "v1/swagger.yaml", type: :request do
  path "/api/tasks" do
    get("Lists all tasks") do
      tags "Tasks"
      produces "application/json"

      response "200", "Tasks list" do
        schema type: :array, items: {type: :object}
        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end
    end

    post("Creates a task") do
      tags "Tasks"
      consumes "application/json"
      produces "application/json"

      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          task: {
            type: :object,
            properties: {
              title: {type: :string, example: "Test"}
            },
            required: ["title"]
          }
        },
        required: ["task"]
      }

      response "201", "Task created" do
        let(:task) { {task: {title: "Test"}} }
        schema type: :object,
          properties: {
            id: {type: :integer},
            title: {type: :string},
            created_at: {type: :string, format: "date-time"},
            updated_at: {type: :string, format: "date-time"}
          },
          required: ["id", "title", "created_at", "updated_at"]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["title"]).to eq "Test"
          expect(response).to have_http_status(:created)
        end
      end

      response "422", "Invalid request" do
        let(:task) { {task: {title: nil}} }
        schema type: :object,
          properties: {
            errors: {type: :array, items: {type: :string}}
          },
          required: ["errors"]

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data["errors"]).to include "Title can't be blank"
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
