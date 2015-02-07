require 'minitest/autorun'
require 'dotenv'
Dotenv.load
require_relative '../lib/ispapi'

class TestTexterraAPI < Minitest::Test

  def setup
    @texterra = TexterraAPI.new ENV['KEY'], ENV['SERVICE_NAME'], ENV['SERVICE_VERSION']
    @en_text = 'Apple today updated iMac to bring numerous high-performance enhancements to the =s leading all-in-one desktop. iMac now features fourth-generation Intel Core processors, new graphics, and next-generation Wi-Fi. In addition, it now supports PCIe-based flash storage, making its Fusion Drive and all-flash storage options up to 50 percent faster than the previous generation'
    @ru_text = 'Первые в этом году переговоры министра иностранных дел России Сергея Лаврова и госсекретаря США Джона Керри, длившиеся 1,5 часа, завершились в Мюнхене.'
    @en_tweet = 'mentioning veterens care which Mccain has voted AGAINST - SUPER GOOOOD point Obama+1 #tweetdebate'
    @ru_tweet = 'В мастерской готовят пушку и автомобили 1940-х годов, для участия в Параде Победы в Ново-Переделкино.'
  end  

  def test_key_concepts
    assert_instance_of Array, @texterra.key_concepts(@en_text) 
    assert_instance_of Array, @texterra.key_concepts(@ru_text) 
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

  def test_tweet_normalization
    assert_instance_of Array, @texterra.tweet_normalization(@en_tweet) 
    assert_raises ApiError do 
      @texterra.tweet_normalization(@ru_text) 
    end
  end

end