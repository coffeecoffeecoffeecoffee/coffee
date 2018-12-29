require "rspec/expectations"

RSpec::Matchers.define :match_openapi_spec do |path, verb|
  match do |response|
    status = response.status.to_s
    content_type = response.content_type
    body = JSON.parse(response.body)

    @actual = body

    definition = OasParser::Definition.resolve("docs/openapi.yaml")
    path = definition.path_by_path(path)
    endpoint = path.endpoint_by_method(verb)
    response = endpoint.response_by_code(status)
    schema_data = response.schema(content_type).as_json

    @expected = schema_data

    schema = JsonSchema.parse!(schema_data)
    schema.validate!(body, fail_fast: true)

    true
  end

  failure_message do
    "expected: #{@actual}\n to match OpenAPI spec: #{@expected}"
  end

  failure_message_when_negated do
    "expected: #{@actual}\n not to match OpenAPI spec: #{@expected}"
  end
end
