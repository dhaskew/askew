require_relative "test_helper.rb"

class ConfigTest < Minitest::Test

  def test_valid_config 
    config = Askew::Config.new "./askew.config"
    assert config.valid?, true
  end

end
