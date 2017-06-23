require_relative "../test_helper.rb"

class TaskCommandTest < Minitest::Test

  ORIGINAL_CONFIG_FILE_CONSTANT_VALUE = Askew::Config::DEFAULT_CONFIG_FILE
  ORIGINAL_CONFIG_FILE_CONSTANT_NAME = "DEFAULT_CONFIG_FILE"
 
  TEST_CONFIG_FILE = "test/inputs/test.config"

  def setup
    # https://stackoverflow.com/questions/3375360/how-to-redefine-a-ruby-constant-without-warning
    Askew::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    Askew::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, TEST_CONFIG_FILE)
  end

  def teardown
    Askew::Config.send(:remove_const, ORIGINAL_CONFIG_FILE_CONSTANT_NAME)
    Askew::Config.const_set(ORIGINAL_CONFIG_FILE_CONSTANT_NAME, ORIGINAL_CONFIG_FILE_CONSTANT_VALUE)
  end

  def test_task_can_be_added
   begin 
    config_path = File.expand_path(TEST_CONFIG_FILE)
    config = Askew::Config.new config_path
    task_file = Askew::Config.new(TEST_CONFIG_FILE).todo_file
    out, err = capture_io {
#      FakeFS.with_fresh do
#        FakeFS::FileSystem.clone(File.expand_path(config_path))
#        FakeFS::FileSystem.clone(File.expand_path(task_file))
        Askew::CLI.start %w{ version }
     # end 
    }
   rescue
     puts "exception happend"
   end
    puts "foobar"
    puts out
    assert out == Askew::VersionCommand::VERSION + "\n"
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
