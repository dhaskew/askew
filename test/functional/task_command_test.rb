require_relative "../test_helper.rb"

class TaskCommandTest < Minitest::Test

  ORIGINAL_CONFIG_FILE_CONSTANT_VALUE = Askew::Config::DEFAULT_CONFIG_FILE
  ORIGINAL_CONFIG_FILE_CONSTANT_NAME = "DEFAULT_CONFIG_FILE"
  TEST_CONFIG_FILE = File.expand_path("test/inputs/test.config")

  def setup
    # https://stackoverflow.com/questions/3375360/how-to-redefine-a-ruby-constant-without-warning
    Askew::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    Askew::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, TEST_CONFIG_FILE)
  end

  def teardown
    Askew::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    Askew::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, ORIGINAL_CONFIG_FILE_CONSTANT_VALUE)
  end

  def test_stub_test

    #mock example
    mock_config = Minitest::Mock.new
    mock_config.expect :path , "foobar"
    mock_config.expect :valid?, "foobar"

    Askew::Config.stub(:new , mock_config) do
      config = Askew::Config.new(Askew::Config::DEFAULT_CONFIG_FILE)
      assert_equal config.valid? , "foobar"
      assert_equal config.path , "foobar"
    end

    #stub example
    test_config = Askew::Config.new(Askew::Config::DEFAULT_CONFIG_FILE)

    test_config.stub :valid?, "foobar" do
      assert_equal test_config.valid? ,"foobar"
    end

  end

  def test_validate_test_config_setup
    skip
    assert_equal Askew::Startup.config_file , TEST_CONFIG_FILE
    assert_equal Askew::Startup.config_file , Askew::Config::DEFAULT_CONFIG_FILE
    refute_equal Askew::Startup.config_file , ORIGINAL_CONFIG_FILE_CONSTANT_VALUE
    assert_equal Askew::Startup.config.path , TEST_CONFIG_FILE
  end

  def test_task_can_be_added
    skip
    out, err = capture_io {
      Askew::CLI.start %w{ version }
    }
    assert_equal  out , Askew::VersionCommand::VERSION + "\n"
  end

  def test_task_can_be_removed
    skip
  end

  def test_task_can_be_shown
    skip
  end

  def test_task_can_be_done
    skip
  end

  def test_task_can_be_undone
    skip
  end

  def test_task_can_be_updated
    skip
  end

  def test_task_can_be_prioritized
    skip
  end

  def test_task_can_be_deprioritized
    skip
  end

  def test_task_can_have_priority_removed
    skip
  end

  def test_task_can_be_tagged
    skip
  end

  def test_task_can_be_added_to_project
    skip
  end

  def test_task_can_be_contextualized
    skip
  end

  def test_task_can_be_navigated_to
    skip
  end

  def test_task_can_be_archived
    skip
  end

end
