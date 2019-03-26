# frozen_string_literal: true

require 'mu/result'
require 'json'

# :nodoc:
module JSONUtils
  include Mu

  module_function

  def parse(json)
    data = ::JSON.parse(json)
    Result.success(data)
  rescue ::JSON::ParserError
    Result.error.code!(:invalid_json)
  end

  def generate(data)
    json = ::JSON.generate(data)
    Result.success(json)
  rescue ::JSON::GeneratorError
    Result.error.code!(:json_serialization_error)
  end
end
