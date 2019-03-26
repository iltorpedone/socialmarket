# frozen_string_literal: true

require 'fileutils'
require 'net/http'
require 'uri'
require 'mu/result'
require_relative 'json_utils'

# :nodoc:
class RestClient
  include Mu

  def self.api_request(
    method: :get,
    domain:,
    scheme: 'https',
    port: 443,
    path: '/',
    uri_params: {},
    body_params: {},
    headers: {},
    success_codes: ['200'],
    is_json: true,
    basic_authentication: nil)
    result = request(
      method: method,
      scheme: scheme,
      port: port,
      domain: domain,
      path: path,
      body_params: body_params,
      uri_params: uri_params,
      headers: headers,
      basic_authentication: basic_authentication,
    )
    return result if result.error?

    response = result.data[:response]

    application_response(
      response: response,
      success_codes: success_codes,
      is_json: is_json,
    )
  end

  # private

  def self.request(
    method: :get,
    domain:,
    scheme: 'https',
    port: 443,
    path: '/',
    uri_params: {},
    body_params: {},
    headers: {},
    basic_authentication: nil)
    draft_uri = "#{scheme}://#{domain}#{port == 80 ? '' : ":#{port}"}#{path}"
    if uri_params.any?
      draft_uri = "#{draft_uri}?#{URI.encode_www_form(uri_params)}"
    end
    uri = URI(draft_uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: scheme == 'https') do |http|
      request = request_class(method: method).new(uri)
      if headers.any?
        headers.each do |key, value|
          request[key] = value
        end
      end
      request.body = ::JSON.generate(body_params) if body_params.any?
      if basic_authentication
        request.basic_auth(
          basic_authentication.username,
          basic_authentication.password,
        )
      end
      response = http.request(request)
      Result.success(response: response)
    end
  end

  def self.request_class(method:)
    case method
    when :get then Net::HTTP::Get
    when :post then Net::HTTP::Post
    when :delete then Net::HTTP::Delete
    when :put then Net::HTTP::Put
    when :patch then Net::HTTP::Patch
    else
      raise "HTTP method '#{method}' is not recognized."
    end
  end

  def self.application_response(response:,
                                success_codes: ['200'],
                                is_json: true)
    unless success_codes.include?(response.code)
      return Result.error(response: response).code!(:http_error)
    end
    return Result.success(response: response) unless is_json

    result = JSONUtils.parse(response.body)
    return result if result.error?

    Result.success(
      response: response,
      json: result.data,
    )
  end
end
