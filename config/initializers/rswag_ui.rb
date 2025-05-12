Rswag::Ui.configure do |c|
  # List the Swagger endpoints that you want to be documented through the
  # swagger-ui. The key is the name displayed in the basic auth dialog and
  # the value is the URL to the OpenAPI file.
  c.swagger_endpoint "/api-docs/v1/swagger.yaml", "API V1 Docs"

  # Add Basic Auth in case your API is private
  # c.basic_auth_enabled = true
  # c.basic_auth_credentials 'username', 'password'
end
