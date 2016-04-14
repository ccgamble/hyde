require '../test/test_helper'
require '../lib/bones'

class BonesTest < Minitest::Test

  def test_that_directory_is_created
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    assert Dir.exist?(Dir.home + "/test")
  end

  def test_root_path_works
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    bones.root_path
    assert Dir.exist?(Dir.home + "/test")
  end

  def test_copy_files_actually_copies_stuff
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    bones.site_generator
    FileUtils.cp_r(Dir.home + "/test", Dir.home + "/test2")
    assert Dir.exist?(Dir.home + "/test2")
  end

  def test_post_method
    bones = Bones.new(ARGV)
    today = Time.new.strftime('%Y-%m-%d-')
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.post
    assert File.exist?(Dir.home + "/test/source/posts/#{today}post1.md")
  end


end
