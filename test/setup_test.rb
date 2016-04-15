require '../test/test_helper'
require '../lib/setup'
require '../lib/bones'

class SetupTest < Minitest::Test

  def test_subcommand_outputs_error_when_argv0_is_not_a_valid_command
    setup = Setup.new
    ARGV[0] = "test"
    assert_equal "ERROR", setup.subcommand
  end

  def test_subcommand_works_with_new
    setup = Setup.new
    ARGV[0] = "new"
    ARGV[1] = "test"
    setup.subcommand
    assert Dir.exist?(Dir.home + "/test")
  end

  def test_subcommand_works_with_build
    setup = Setup.new
    ARGV[0] = "build"
    ARGV[1] = "test"
    setup.subcommand
    assert Dir.exist?(Dir.home + "/test/_output/css")
  end

  def test_subcommand_works_with_post
    today = Time.new.strftime('%Y-%m-%d-')
    setup = Setup.new
    ARGV[0] = "post"
    ARGV[1] = "test"
    ARGV[2] = "post1"
    setup.subcommand
    assert File.exist?(Dir.home + "/test/source/posts/#{today}post1.md")
  end

  def test_errors_show_when_trying_to_create_same_blog
    setup = Setup.new
    ARGV[0] = "post"
    ARGV[1] = "test"
    setup.dir_exists
    setup.dir_exists
    assert_equal "Error, File path already exists", setup.dir_exists
  end
end
