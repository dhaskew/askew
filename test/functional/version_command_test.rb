require_relative "../test_helper.rb"

class VersionCommandTest < Minitest::Test

  def test_cli_version_command
    out, err = capture_io {
      AskewClient::CLI.start %w{ version }
    }
    assert out == AskewClient::VersionCommand::VERSION + "\n"
  end

  def test_cli_version_major_command
    out, err = capture_io {
      AskewClient::CLI.start %w{ version major }
    }
    assert out == AskewClient::VersionCommand::VERSION_MAJOR + "\n"
  end
  

  def test_cli_version_minor_command
    out, err = capture_io {
      AskewClient::CLI.start %w{ version minor }
    }
    assert out == AskewClient::VersionCommand::VERSION_MINOR + "\n"
  end

  def test_cli_version_patch_command
    out, err = capture_io {
      AskewClient::CLI.start %w{ version patch }
    }
    assert out == AskewClient::VersionCommand::VERSION_PATCH + "\n"
  end

end
