require 'json'
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
  parser(
    proc do |data|
      result = nori.parse(data)
      begin
        result = JSON.parse(data, symbolize_names: true) if result.empty?
      rescue
      end
      result
    end
  )

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
    key_concepts = key_concepts_annotate(text)[:annotations][:keyconcepts][0][:value] || []
  end

  # Detects whether the given text has positive, negative or no sentiment
  #
  # @param [String] text Text to process
  # @return [String] Sentiment of the text
  def sentiment_analysis(text)
    polarity_detection_annotate(text)[:annotations][:polarity][0][:value].to_s || 'NEUTRAL'
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
    annotations = domain_polarity_detection_annotate(text, domain)[:annotations]
    begin
      used_domain = annotations[:domain][0][:value]
      sentiment = annotations[:polarity][0][:value]
    rescue NoMethodError
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
    disambiguation_annotate(text)[:annotations][:'disambiguated-phrase']
  end

  def custom_query(path, query, form = nil)
    form.nil? ? GET(path, query) : POST(path, query, form)
  end
end
