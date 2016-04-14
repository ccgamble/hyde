require '../test/test_helper'
require '../lib/setup'

class SetupTest < Minitest::Test

  def test_it_throws_error_when_argv0_is_not_new
    setup = Setup.new
    ARGV[0] = "test"
    assert_equal "ERROR", setup.run_menu
  end

  def test_it_finds_markdown_file
    setup = Setup.new
    ARGV[1] = "test"
    require 'pry'; binding.pry
    assert Dir.exist?("/Users/luigiaversano/test/source/index.md")
  end
end
