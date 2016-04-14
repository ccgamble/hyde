require '../test/test_helper'
require '../lib/setup'
require '../lib/bones'

class SetupTest < Minitest::Test

  def test_subcommand_outputs_error_when_argv0_is_not_a_valid_command
    setup = Setup.new
    ARGV[0] = "test"
    assert_equal "ERROR", setup.subcommand
  end
end
