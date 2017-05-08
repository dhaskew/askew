require_relative "../test_helper.rb"

class CliTest < Minitest::Test

  def test_cli_version_command
    out, err = capture_io {
      Askew::CLI.start %w{ version }
    }
    assert out == Askew::VersionCommand::VERSION + "\n"
  end

end
