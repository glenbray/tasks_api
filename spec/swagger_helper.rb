require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api Rails engine ensure Acceptance Testing is enabled by uncommenting the following line
  # config.openapi_root = Rails.root.join('swagger').to_s

  # Specify the output directory for generated Swagger JSON files
  config.openapi_root = Rails.root.join("swagger").to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run 'rspec' with the SWAGGER_DRY_RUN environment variable set to true,
  # the build process will stop RSpec tests accept examples and verify expectations
  # and provide validation errors. You can use the RSpec SWAGGER_DRY_RUN=true to discover
  # the validation error message that are report by rswag-specs.
  config.openapi_specs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      servers: [
        {
          url: "http://{defaultHost}",
          variables: {
            defaultHost: {
              default: "localhost:3000"
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
