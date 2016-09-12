require 'json'
require 'httparty'
require 'nori'
require_relative './api_error'

class IsprasAPI
  include HTTParty
  # debug_output $stdout
  ROOT_URL = 'api.ispras.ru/%s/%s'

  def initialize(key, name, ver)
    if key && key.size == 40
      self.class.base_uri format(ROOT_URL, name, ver)
      self.class.default_params apikey: key
      self.class.read_timeout 60
    else
      fail ApiError, 'Please provide proper apikey'
    end
  end

  def GET(path = '', params = {}, format=:xml)
    options = {
      headers: headers(format),
      query: params
    }
    response = self.class.get "/#{path}", options
    response.code == 200 ? response.parsed_response : check_error(response)
  end

  def POST(path = '', params = {}, body = {}, format=:xml)
    options = {
      headers: headers(format),
      query: params,
      body: body
    }
    response = self.class.post "/#{path}", options
    response.code == 200 ? response.parsed_response : check_error(response)
  end

  private

  def headers(format)
    case(format)
    when :json
      {
        'Accept' => 'application/json'
      }
    when :xml
      {
        'Accept' => 'application/xml'
      }
    else
      {}
    end
  end

  def check_error(response)
    fail ApiError, "#{response.code} Error occured"
  end
end
