require_relative "../test_helper.rb"

class TaskCommandTest < Minitest::Test

  ORIGINAL_CONFIG_FILE_CONSTANT_VALUE = AskewClient::Config::DEFAULT_CONFIG_FILE
  ORIGINAL_CONFIG_FILE_CONSTANT_NAME = "DEFAULT_CONFIG_FILE"
  TEST_CONFIG_FILE = File.expand_path("test/inputs/test.config")

  def setup
    # https://stackoverflow.com/questions/3375360/how-to-redefine-a-ruby-constant-without-warning
    AskewClient::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    AskewClient::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, TEST_CONFIG_FILE)
  end

  def teardown
    AskewClient::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    AskewClient::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, ORIGINAL_CONFIG_FILE_CONSTANT_VALUE)
  end

  def test_stub_test

    #mock example
    mock_config = Minitest::Mock.new
    mock_config.expect :path , "foobar"
    mock_config.expect :valid?, "foobar"

    AskewClient::Config.stub(:new , mock_config) do
      config = AskewClient::Config.new(AskewClient::Config::DEFAULT_CONFIG_FILE)
      assert_equal config.valid? , "foobar"
      assert_equal config.path , "foobar"
    end

    #stub example
    test_config = AskewClient::Config.new(AskewClient::Config::DEFAULT_CONFIG_FILE)

    test_config.stub :valid?, "foobar" do
      assert_equal test_config.valid? ,"foobar"
    end

  end

  def test_validate_test_config_setup
    skip
    assert_equal AskewClient::Startup.config_file , TEST_CONFIG_FILE
    assert_equal AskewClient::Startup.config_file , Askew::Config::DEFAULT_CONFIG_FILE
    refute_equal AskewClient::Startup.config_file , ORIGINAL_CONFIG_FILE_CONSTANT_VALUE
    assert_equal AskewClient::Startup.config.path , TEST_CONFIG_FILE
  end

  def test_task_can_be_added
    skip
  end

  def test_task_can_be_removed
    skip
  end


  def test_show_task_has_header
    skip
  end

  def test_shown_task_has_id
    skip
    #This works, but should mock the FileIO to read from memory
    out, err = capture_io {
      AskewClient::CLI.start %w{ task show 1 }
    }
    assert_match %r%ID%, out.lines[3]
  end

  def test_shown_task_has_text
    skip
  end

  def test_shown_task_has_raw_line_info
    skip
  end

  def test_shown_task_can_have_priority
    skip
  end

  def test_shown_task_can_have_contexts
    skip
  end

  def test_shown_task_can_have_projects
    skip
  end

  def test_show_task_can_have_tags
    skip
  end

  def test_shown_task_can_have_created_date
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
    #https://drivy.engineering/running-capybara-headless-chrome/
    skip
  end

  def test_task_can_be_archived
    skip
  end

end
