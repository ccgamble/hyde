require '../test/test_helper'
require '../lib/bones'

class BonesTest < Minitest::Test

  def test_that_directory_is_created
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    assert Dir.exist?("/Users/luigiaversano/test")
  end

  def test_root_path_works
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    bones.root_path
    assert Dir.exist?("/Users/luigiaversano/test")
  end

  def test_copy_files_actually_copies_stuff
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    FileUtils.cp_r("/Users/luigiaversano/test","/Users/luigiaversano/test2")
    assert Dir.exist?("/Users/luigiaversano/test2")
  end

  def teardown
    FileUtils.rm_rf("/Users/luigiaversano/test")
    FileUtils.rm_rf("/Users/luigiaversano/test2")
  end
end
