require '../test/test_helper'
require '../lib/setup'


class SetupTest < Minitest::Test

  def test_it_throws_error_when_argv0_is_not_new
    setup = Setup.new
    ARGV[0] = "test"
    assert_equal "ERROR", setup.run_menu
  end
end
