require '../test/test_helper'
require '../lib/bones'


class BonesTest < Minitest::Test

  def test_that_directory_is_created
    bones = Bones.new(ARGV)
    ARGV[0] = "test"
    bones.site_generator
    assert Dir.exist?("/Users/luigiaversano/test")
  end

  def teardown
    FileUtils.rm_rf("/Users/luigiaversano/test")
  end
end
