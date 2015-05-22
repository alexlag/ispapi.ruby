require 'minitest/autorun'
require 'dotenv'
Dotenv.load
require_relative '../lib/ispras-api/texterra_api'

class TestTexterraAPI < Minitest::Test
  def setup
    @texterra = TexterraAPI.new ENV['TEXTERRA_KEY'], ENV['TEXTERRA_SERVICE_NAME'], ENV['TEXTERRA_SERVICE_VERSION']
    @en_text = 'Apple today updated iMac to bring numerous high-performance enhancements to the leading all-in-one desktop. iMac now features fourth-generation Intel Core processors, new graphics, and next-generation Wi-Fi. In addition, it now supports PCIe-based flash storage, making its Fusion Drive and all-flash storage options up to 50 percent faster than the previous generation'
    @ru_text = 'Первые в этом году переговоры министра иностранных дел России Сергея Лаврова и госсекретаря США Джона Керри, длившиеся 1,5 часа, завершились в Мюнхене.'
    @en_tweet = 'mentioning veterens care which Mccain has voted AGAINST - SUPER GOOOOD point Obama+1 #tweetdebate'
    @ru_tweet = 'В мастерской готовят пушку и автомобили 1940-х годов, для участия в Параде Победы в Ново-Переделкино.'
  end

  def test_key_concepts
    assert_instance_of Array, @texterra.key_concepts(@en_text)
    assert_instance_of Array, @texterra.key_concepts(@ru_text)
    assert_instance_of Array, @texterra.key_concepts(@en_tweet)
    assert_instance_of Array, @texterra.key_concepts(@ru_tweet)
  end

  def test_disambiguation
    assert_instance_of Array, @texterra.disambiguation(@en_text)
    assert_instance_of Array, @texterra.disambiguation(@ru_text)
  end

  def test_sentiment_analysis
    assert_instance_of String, @texterra.sentiment_analysis(@en_text)
    assert_instance_of String, @texterra.sentiment_analysis(@ru_text)
    assert_instance_of String, @texterra.sentiment_analysis(@en_tweet)
    assert_instance_of String, @texterra.sentiment_analysis(@ru_tweet)
  end

  def test_domain_sentiment_analysis
    assert_instance_of Hash, @texterra.domain_sentiment_analysis(@en_text)
    assert_instance_of Hash, @texterra.domain_sentiment_analysis(@ru_text)
    res = @texterra.domain_sentiment_analysis(@en_tweet, 'politics')
    assert_instance_of Hash, res
    assert_equal 'politics', res[:domain]
    assert_raises ApiError do
      @texterra.domain_sentiment_analysis(@ru_text, 'politics')
    end
  end

  def test_tweet_normalization
    assert_instance_of Array, @texterra.tweet_normalization(@en_tweet)
    assert_raises ApiError do
      @texterra.tweet_normalization(@ru_tweet)
    end
  end

  def test_syntax_detection
    assert_instance_of Array, @texterra.syntax_detection(@ru_text)
  end

  def test_language_detection_annotate
    assert_instance_of Array, @texterra.language_detection_annotate(@en_text)
    assert_instance_of Array, @texterra.language_detection_annotate(@ru_text)
    assert_instance_of Array, @texterra.language_detection_annotate(@en_tweet)
    assert_instance_of Array, @texterra.language_detection_annotate(@ru_tweet)
  end

  def test_sentence_detection_annotate
    assert_instance_of Array, @texterra.sentence_detection_annotate(@en_text)
    assert_instance_of Array, @texterra.sentence_detection_annotate(@ru_text)
    assert_instance_of Array, @texterra.sentence_detection_annotate(@en_tweet)
    assert_instance_of Array, @texterra.sentence_detection_annotate(@ru_tweet)
  end

  def test_tokenization_annotate
    assert_instance_of Array, @texterra.tokenization_annotate(@en_text)
    assert_instance_of Array, @texterra.tokenization_annotate(@ru_text)
    assert_instance_of Array, @texterra.tokenization_annotate(@en_tweet)
    assert_instance_of Array, @texterra.tokenization_annotate(@ru_tweet)
  end

  def test_lemmatization_annotate
    assert_instance_of Array, @texterra.lemmatization_annotate(@en_text)
    assert_instance_of Array, @texterra.lemmatization_annotate(@ru_text)
    assert_instance_of Array, @texterra.lemmatization_annotate(@en_tweet)
    assert_instance_of Array, @texterra.lemmatization_annotate(@ru_tweet)
  end

  def test_pos_tagging_annotate
    assert_instance_of Array, @texterra.pos_tagging_annotate(@en_text)
    assert_instance_of Array, @texterra.pos_tagging_annotate(@ru_text)
    assert_instance_of Array, @texterra.pos_tagging_annotate(@en_tweet)
    assert_instance_of Array, @texterra.pos_tagging_annotate(@ru_tweet)
  end

  def test_named_entities_annotate
    assert_instance_of Array, @texterra.named_entities_annotate(@en_text)
    assert_instance_of Array, @texterra.named_entities_annotate(@ru_text)
    assert_instance_of Array, @texterra.named_entities_annotate(@en_tweet)
    assert_instance_of Array, @texterra.named_entities_annotate(@ru_tweet)
  end

  def test_subjectivity_detection_annotate
    assert_instance_of Array, @texterra.subjectivity_detection_annotate(@en_text)
    assert_instance_of Array, @texterra.subjectivity_detection_annotate(@ru_text)
    assert_instance_of Array, @texterra.subjectivity_detection_annotate(@en_tweet)
    assert_instance_of Array, @texterra.subjectivity_detection_annotate(@ru_tweet)
  end

  def test_term_presence
    res = @texterra.term_presence('Anarchism')
    assert_instance_of Hash, res
    assert_equal true, res[:presence]
  end

  def test_term_info_measure
    assert_instance_of Hash, @texterra.term_info_measure('Anarchism')
  end

  def test_term_meanings
    assert_instance_of Hash, @texterra.term_meanings('android')
  end

  def test_term_commonness
    assert_instance_of Hash, @texterra.term_commonness('android')
    assert_instance_of Hash, @texterra.term_commonness('android', '713:enwiki')
  end

  def test_neignbours
    assert_instance_of Hash, @texterra.neighbours('12:enwiki')
    assert_instance_of Hash, @texterra.neighbours('12:enwiki', linkType: 'RELATED', nodeType: 'REGULAR', minDepth: 1, maxDepth: 3)
    assert_instance_of Hash, @texterra.neighbours(['12:enwiki', '713:enwiki'])
    assert_instance_of Hash, @texterra.neighbours(['12:enwiki', '713:enwiki'], linkType: 'RELATED', nodeType: 'REGULAR', minDepth: 1, maxDepth: 3)
  end

  def test_neignbours_size
    assert_instance_of Hash, @texterra.neighbours_size('12:enwiki')
    assert_instance_of Hash, @texterra.neighbours_size('12:enwiki', linkType: 'RELATED', nodeType: 'REGULAR', minDepth: 1, maxDepth: 3)
    assert_instance_of Hash, @texterra.neighbours_size(['12:enwiki', '713:enwiki'])
    assert_instance_of Hash, @texterra.neighbours_size(['12:enwiki', '713:enwiki'], linkType: 'RELATED', nodeType: 'REGULAR', minDepth: 1, maxDepth: 3)
  end

  def test_similarity_graph
    assert_instance_of Hash, @texterra.similarity_graph(['12:enwiki', '13137:enwiki', '156327:enwiki'])
    assert_instance_of Hash, @texterra.similarity_graph(['12:enwiki', '13137:enwiki', '156327:enwiki'], 'MIN')
  end

  def test_all_pairs_similarity
    assert_instance_of Hash, @texterra.all_pairs_similarity(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'])
    assert_instance_of Hash, @texterra.all_pairs_similarity(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'], 'MIN')
  end

  def test_similarity_to_virtual_article
    assert_instance_of Hash, @texterra.similarity_to_virtual_article(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'])
    assert_instance_of Hash, @texterra.similarity_to_virtual_article(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'], 'MIN')
  end

  def test_similarity_between_virtual_articles
    assert_instance_of Hash, @texterra.similarity_between_virtual_articles(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'])
    assert_instance_of Hash, @texterra.similarity_between_virtual_articles(['12:enwiki', '13137:enwiki'], ['156327:enwiki', '15942292:enwiki', '1921431:enwiki'], 'MIN')
  end

  def test_similar_over_first_neighbours
    assert_instance_of Hash, @texterra.similar_over_first_neighbours('12:enwiki')
    assert_instance_of Hash, @texterra.similar_over_first_neighbours('12:enwiki', linkWeight: 'MIN', offset: 1, limit: 3)
  end

  def test_similar_over_filtered_neighbours
    assert_instance_of Hash, @texterra.similar_over_filtered_neighbours('12:enwiki')
    assert_instance_of Hash, @texterra.similar_over_filtered_neighbours('12:enwiki', linkWeight: 'MIN', offset: 1, limit: 3, among: 'PORTION(0.2)')
  end

  def test_get_attributes
    assert_instance_of Hash, @texterra.get_attributes('12:enwiki')
    assert_instance_of Hash, @texterra.get_attributes(['12:enwiki', '13137:enwiki'])
    assert_instance_of Hash, @texterra.get_attributes('12:enwiki', ['url(en)', 'type'])
    assert_instance_of Hash, @texterra.get_attributes(['12:enwiki', '13137:enwiki'], ['url(en)', 'title'])
  end
end
