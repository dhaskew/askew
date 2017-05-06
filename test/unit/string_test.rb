require_relative "../test_helper.rb"

class StringTest < Minitest::Test

  def setup
    @string_test = "test" 
  end

  def test_string_apply_color_handles_nil
    assert @string_test.apply_color(nil) != nil
  end

end
