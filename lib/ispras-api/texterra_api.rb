require_relative './ispras_api'
require_relative './texterra/nlp'
require_relative './texterra/kbm'

class TexterraAPI < IsprasAPI
  # This class provides methods to work with Texterra REST via OpenAPI,
  # including NLP and EKB methods and custom queries
  # Note that NLP methods return annotations only
  include TexterraNLP, TexterraKBM
  disable_rails_query_string_format
  nori = Nori.new(parser: :rexml,
                  convert_tags_to: ->(tag) { tag.snakecase.to_sym })
  parser proc { |data| nori.parse data }

  def initialize(key, name = nil, ver = nil)
    name = 'texterra' if name.nil? || name.empty?
    ver = 'v3.1' if ver.nil? || ver.empty?
    super(key, name, ver)
  end

  # Section of NLP methods
  # NLP basic helper methods

  # Key concepts are the concepts providing
  # short (conceptual) and informative text description.
  # This service extracts a set of key concepts for a given text
  #
  # @param [String] text Text to process
  # @return [Array] Array of weighted key concepts
  def key_concepts(text)
    key_concepts = key_concepts_annotate(text)[0][:value][:concepts_weights][:entry] || []
    key_concepts = [].push key_concepts unless key_concepts.is_a? Array
    key_concepts.map do |kc|
      kc[:concept][:weight] = kc[:double] 
      kc[:concept]
    end
  end

  # Detects whether the given text has positive, negative or no sentiment
  #
  # @param [String] text Text to process
  # @return [Array] Sentiment of the text
  def sentiment_analysis(text)
    polarity_detection_annotate(text)[0][:value].to_s || 'NEUTRAL'
    rescue NoMethodError
      'NEUTRAL'
  end

  # Detects whether the given text has positive, negative, or no sentiment, with respect to domain.
  # If domain isn't provided, Domain detection is applied, this way method tries to achieve best results.
  # If no domain is detected general domain algorithm is applied
  #
  # @param [String] text Text to process
  # @param domain [String] domain to use. Can be empty
  # @return [Hash] used :domain and detected :polarity
  def domain_sentiment_analysis(text, domain = '')
    used_domain = 'general'
    sentiment = 'NEUTRAL'
    (domain_polarity_detection_annotate(text, domain) || []).each do |an|
      sentiment = an[:value] if an[:@class].include? 'SentimentPolarity'
      used_domain = an[:value] if an[:@class].include? 'DomainAnnotation'
    end
    {
      domain: used_domain,
      polarity: sentiment
    }
  end

  # Detects the most appropriate meanings (concepts) for terms occurred in a given text
  #
  # @param [String] text Text to process
  # @return [Array] Texterra annotations
  def disambiguation(text)
    disambiguation_annotate(text)
  end

  def custom_query(path, query, form = nil)
    form.nil? ? GET(path, query) : POST(path, query, form)
  end

  private

  def check_error(response)
    hash = response.parsed_response
    er_node = hash[:html][:body][:p].detect do |node|
      node.is_a?(Hash) && node[:b] == 'root cause'
    end
    fail ApiError, er_node[:pre].gsub(/ru\.ispras.*:\s*/, '')
  end
end
