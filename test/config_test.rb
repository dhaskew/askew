require_relative "test_helper.rb"

class ConfigTest < Minitest::Test

  def test_valid_config 
    config = Askew::Config.new "/home/dhaskew/.askew/askew.config"
    assert config.valid?, true
  end

end
