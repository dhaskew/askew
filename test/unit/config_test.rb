require_relative "../test_helper.rb"

class ConfigTest < Minitest::Test

  def test_valid_config 
    config = AskewClient::Config.new File.expand_path('test/inputs/test.config')
    assert_equal config.valid?, true
  end

end
