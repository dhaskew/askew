require "minitest/autorun"

class AskewTest < Minitest::Test

  def steup
    puts "test"
  end

  def test_bogus_stuff
    assert_equal 1,1
    assert_equal 2,1
  end

  def test_to_be_skipped
    skip "skipping this test"
  end

end