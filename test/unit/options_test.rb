require_relative '../test_helper.rb'

class OptionsTest < Minitest::Test

  def setup
    @opt = Askew::Options.new 
  end

  def test_can_create_instance 
    assert @opt != nil 
  end

end
