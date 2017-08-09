require_relative "../test_helper.rb"

class StartupTest < Minitest::Test

  def setup
    AskewClient::Startup.remove_class_variable :@@config if AskewClient::Startup.class_variable_defined? :@@config
    AskewClient::Startup.remove_class_variable :@@config_file if AskewClient::Startup.class_variable_defined? :@@config_file
  end

  def test_config_file_is_blank_until_config_processed
    assert_nil AskewClient::Startup.config_file
    AskewClient::Startup.process_config
    refute_nil AskewClient::Startup.config_file
  end

  def test_config_is_blank_until_config_processed
    assert_nil AskewClient::Startup.config
    AskewClient::Startup.process_config
    refute_nil AskewClient::Startup.config
  end

  def test_no_valid_config_raises_exception
    skip
    #assert_raises Exception do
      #empty filesystem means the file doesn't exist
    #  MemFs.activate!
        #tfile = ENV['HOME'] + "/.askew/askew.config"
    #    AskewClient::Startup.process_config
    #  MemFs.deactive!
    #end
  end

end
