require_relative "../test_helper.rb"

class ConfigTest < Minitest::Test

  def test_valid_config 
    config = Askew::Config.new "askew.config.foobar"
    assert_equal config.valid?, true
  end

end
