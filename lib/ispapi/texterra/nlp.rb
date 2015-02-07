require_relative './nlp_specs'

module TexterraNLP
  include TexterraNLPSpecs
  # Detects language of given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def language_detection_annotate(text)
    presetNLP(:languageDetection, text)
  end

  # Detects boundaries of sentences in a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def sentence_detection(text)
    presetNLP(:sentenceDetection, text)
  end

  # Detects all tokens (minimal significant text parts) in a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def tokenization_annotate(text)
    presetNLP(:tokenization, text)
  end

  # Detects lemma of each word of a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def lemmatization_annotate(text)
    presetNLP(:lemmatization, text)
  end

  # Detects part of speech tag for each word of a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def pos_tagging_annotate(text)
    presetNLP(:posTagging, text)
  end

  # Tries to correct disprints and other spelling errors in a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def spelling_correction_annotate(text)
    presetNLP(:spellingCorrection, text)
  end

  # Finds all named entities occurences in a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def named_entities_annotate(text)
    presetNLP(:namedEntities, text)
  end

  # Extracts not overlapping terms within a given text; term is a textual representation for some concept of the real world
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def term_detection_annotate(text)
    presetNLP(:termDetection, text)
  end

  # Detects the most appropriate meanings (concepts) for terms occurred in a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def disambiguation_annotate(text)
    presetNLP(:disambiguation, text)
  end

  # Key concepts are the concepts providing short (conceptual) and informative text description.
  # This service extracts a set of key concepts for a given text
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def key_concepts_annotate(text)
    presetNLP(:keyConcepts, text)
  end

  # Detects the most appropriate domain for the given text.
  # Currently only 2 specific domains are supported: 'movie' and 'politics'
  # If no domain from this list has been detected, the text is assumed to be no domain, or general domain
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def domain_detection_annotate(text)
    presetNLP(:domainDetection, text)
  end

  # Detects whether the given text is subjective or not
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def subjectivity_detection_annotate(text)
    presetNLP(:subjectivityDetection, text)
  end

  # Detects whether the given text has positive, negative or no sentiment
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def polarity_detection_annotate(text)
    presetNLP(:polarityDetection, text)
  end

  # Extracts aspect-sentiment pairs from the given text. Currently only movie domain is supported
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def aspect_extraction_annotate(text)
    presetNLP(:aspectExtraction, text)
  end

  # Detects whether the given text has positive, negative, or no sentiment, with respect to domain. 
  # If domain isn't provided, Domain detection is applied, this way method tries to achieve best results.
  # If no domain is detected general domain algorithm is applied
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def domain_polarity_detection_annotate(text, domain='')
    specs = NLPSpecs[:domainPolarityDetection]
  
    domain = '(%s)' % domain unless domain.empty?
    
    result = POST(specs[:path] % domain, specs[:params], {text: text})[:nlp_document][:annotations][:i_annotation] 

    result = [].push result unless result.is_a? Array

    result.each do |e| 
      st, en  = e[:start].to_i, e[:end].to_i
      e[:text] = e[:annotated_text] = text[st..en]
    end
  end

  # Detects Twitter-specific entities: Hashtags, User names, Emoticons, URLs.
  # And also: Stop-words, Misspellings, Spelling suggestions, Spelling corrections
  # 
  # @param text [String] text to process
  # @return [Array] Texterra annotations
  def tweet_normalization(text)
    presetNLP(:tweetNormalization, text)
  end

  private
    def presetNLP(methodName, text)
      # Utility NLP part method
      specs = NLPSpecs[methodName]
      result = POST(specs[:path], specs[:params], {text: text})[:nlp_document][:annotations][:i_annotation] 

      result = [].push result unless result.is_a? Array
      result.each do |e| 
        st, en  = e[:start].to_i, e[:end].to_i
        e[:text] = e[:annotated_text] = text[st..en]
      end
    end
end