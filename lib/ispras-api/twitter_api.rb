require_relative './ispras_api'

class TwitterAPI < IsprasAPI
  #This class provides methods to work with Twitter NLP REST via OpenAPI
  disable_rails_query_string_format
  nori = Nori.new(parser: :rexml, convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
  parser Proc.new { |data| nori.parse data }

  def initialize(key, name=nil, ver=nil)
    name='twitter-nlp' if name.nil? || name.empty?
    ver='1.0' if ver.nil? || ver.empty?
    super(key, name, ver)
  end

  # Extracts demographic attributes from provided Twitter info. All info is required, but can be empty
  #
  # @param [Hash] params
  # @option params [String] :lang Language of tweets
  # @option params [String] :username Username of Twitter user
  # @option params [String] :screenname Screen name of Twitter user
  # @option params [String] :description Description of Twitter user
  # @option params [String, Array<String>] :tweet User's tweets
  # @return [Hash] Enriched user with attributes
  def extract_dde(params)
    params[:tweet] = params[:tweet].join(' ') if params[:tweet].is_a? Array
    POST 'extract', {}, params
  end

  def custom_query(path, query, form=nil)
    form.nil? ? GET(path, query) : POST(path, query, form)
  end

  private

    def check_error(response)
      hash = response.parsed_response
      er_node = hash[:html][:body][:p].detect { |node| node.is_a? Hash and node[:b] == 'root cause' }
      raise ApiError, er_node[:pre].gsub(/ru\.ispras.*:\s*/, '')
    end

end