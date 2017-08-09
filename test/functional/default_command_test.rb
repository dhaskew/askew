require_relative "../test_helper.rb"

class DefaultCommandTest < Minitest::Test

  # Ensure the default command is "askew task list all",
  # regardless of wether it is executed in whole or in part
  def test_default_command_is_task_list
    out, err = capture_io {
      AskewClient::CLI.start %w{ }
    }

    out2, err2 = capture_io {
      AskewClient::CLI.start %w{ task }
    }

    out3, err3 = capture_io {
      AskewClient::CLI.start %w{ task list }
    }

    out4, err4 = capture_io {
      AskewClient::CLI.start %w{ task list all }
    }

    refute_nil out
    assert_equal out, out2
    assert_equal out, out3
    assert_equal out, out4
  end

end
