#require "minitest/autorun"
require_relative "../test_helper.rb"

class AskewTest < Minitest::Test

  def setup
  
  end

  def test_to_be_skipped
    skip "skipping this test"
  end

end
