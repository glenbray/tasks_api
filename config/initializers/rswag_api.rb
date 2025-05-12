Rswag::Api.configure do |c|
  # Specify the root directory where your OpenAPI specs are located.
  # This is used by the Rswag::Api::Middleware to serve your API descriptions.
  # NOTE: If you changed the openapi_root configuration in `spec/swagger_helper.rb`,
  # you need to update this setting accordingly.
  c.openapi_root = Rails.root.join("swagger").to_s
end
