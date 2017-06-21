require_relative "../test_helper.rb"

class VersionCommandTest < Minitest::Test

  def test_cli_version_command
    out, err = capture_io {
      Askew::CLI.start %w{ version }
    }
    assert out == Askew::VersionCommand::VERSION + "\n"
  end

  def test_cli_version_major_command
    out, err = capture_io {
      Askew::CLI.start %w{ version major }
    }
    assert out == Askew::VersionCommand::VERSION_MAJOR + "\n"
  end
  

  def test_cli_version_minor_command
    out, err = capture_io {
      Askew::CLI.start %w{ version minor }
    }
    assert out == Askew::VersionCommand::VERSION_MINOR + "\n"
  end

  def test_cli_version_patch_command
    out, err = capture_io {
      Askew::CLI.start %w{ version patch }
    }
    assert out == Askew::VersionCommand::VERSION_PATCH + "\n"
  end

end
