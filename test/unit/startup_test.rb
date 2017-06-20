require_relative "../test_helper.rb"

class StartupTest < Minitest::Test

  def setup
    Askew::Startup.remove_class_variable :@@config if Askew::Startup.class_variable_defined? :@@config
    Askew::Startup.remove_class_variable :@@config_file if Askew::Startup.class_variable_defined? :@@config_file
  end

  def test_config_file_is_blank_until_config_processed
    assert_nil Askew::Startup.config_file
    Askew::Startup.process_config
    refute_nil Askew::Startup.config_file
  end

  def test_config_is_blank_until_config_processed
    assert_nil Askew::Startup.config
    Askew::Startup.process_config
    refute_nil Askew::Startup.config
  end

  def test_no_valid_config_raises_exception
    assert_raises Exception do
      #empty filesystem means the file doesn't exist
      FakeFs do
        tfile = ENV['HOME'] + "/.askew/askew.config"
        Askew::Startup.process_config
      end
    end
  end

end
