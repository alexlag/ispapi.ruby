require 'minitest/autorun'
require 'dotenv'
Dotenv.load
require_relative '../lib/ispras-api/twitter_api'

class TestTwitterAPI < Minitest::Test
  def setup
    @twitter = TwitterAPI.new ENV['DDE_KEY'], ENV['DDE_SERVICE_NAME'], ENV['DDE_SERVICE_VERSION']
  end

  def test_extract_dde
    req = { lang: 'en', username: 'Ann', screenname: 'bob', description: 'I am Ann from NY', tweet: 'Hi there, I am Ann fromNY' }
    assert_instance_of Hash, @twitter.extract_dde(req)
  end
end
