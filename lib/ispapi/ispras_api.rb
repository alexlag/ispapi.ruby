require 'httparty'
require 'nori'
require_relative 'api_error'

class IsprasAPI
  include HTTParty
  # debug_output $stdout
  ROOT_URL = 'api.ispras.ru/%s/%s'
  parser Proc.new { |data| data }

  def initialize(key, name, ver)
    if key && key.size == 40
      self.class.base_uri ROOT_URL % [name, ver]
      self.class.default_params apikey: key
      @nori = Nori.new(parser: :rexml, convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
    else
      raise ApiError, 'Please provide proper apikey'
    end
  end

  def GET(path='', params={})
    options = { query: params }
    response = self.class.get "/#{path}", options
    check_error response unless response.code == 200
    hash = @nori.parse response.body
  end

  def POST(path='', params={}, form={})
    options = { query: params, body: form }
    response = self.class.post "/#{path}", options
    check_error response unless response.code == 200
    hash = @nori.parse response.body
  end

  private 

    def check_error(response)
      raise ApiError, "#{response.code} Error occured"
    end

end