require '../test/test_helper'
require '../lib/bones.rb'
require 'tempfile'
require 'fileutils'

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

  def test_it_can_craete_post_method
    bones = Bones.new(ARGV)
    today = Time.new.strftime('%Y-%m-%d-')
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.post

    assert File.exist?(Dir.home + "/test/source/posts/#{today}post1.md")
  end

  def test_markdown_can_be_converted_to_html
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.change_md_to_html
    file = (Dir.home + "/test/_output/index.html")

    assert_equal ".html", File.extname(file)
  end

  def test_it_injects_default_layout_to_html_files
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.build
    file = (Dir.home + "/test/_output/index.html")
    File.read(file)

    assert_equal "<html>\n  <head><title>Our Site</title></head>\n  <body>\n    \n\n    \n  </body>\n</html>\n", File.read(file)
  end

  def test_it_finds_html_files_from_output_folder
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    html_files = bones.find_html

    assert_equal ["/Users/christinegamble/test/_output/index.html",
                  "/Users/christinegamble/test/_output/pages/about.html",
                  "/Users/christinegamble/test/_output/posts/2016-02-20-welcome-to-hyde.html",
                  "/Users/christinegamble/test/_output/posts/2016-04-15-post1.html",
                  "/Users/christinegamble/test/_output/tags/flatbread.html",
                  "/Users/christinegamble/test/_output/tags/italian_food.html"], html_files
  end

  def test_it_can_parse_tags
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.build
    formatted_tags = bones.parse_tags

    assert_equal ["Italian Food", "flatbread"], formatted_tags
  end

  def test_it_can_further_reformat_tags_to_snakecase
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    formatted_tags = bones.parse_tags
    reformat = bones.reformat_tags_to_snakecase

    assert_equal ["italian_food", "flatbread"], reformat
  end

  def test_it_can_read_lines_from_file
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.build
    file = (Dir.home + "/test/_output/index.html")

    assert_equal "  <body>\n", bones.reading_lines(file)[2]
  end

  def test_it_creates_tag_page
    today = Time.new.strftime('%Y-%m-%d-')
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.build
    bones.post
    bones.create_tag_page
    file = Dir.home + "/test/_output/posts/#{today}post1.html"

    assert File.exist?(file)
  end

  def test_it_writes_links_to_posts_in_tag_page
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.build
    bones.write_tag_links_in_post
    File.open(Dir.home + "/test/_output/tags/flatbread.html")
    contents = File.read(Dir.home + "/test/_output/tags/flatbread.html")

    assert contents.include?("test/_output/tags/flatbread.html")
  end

  def test_it_can_track_changes_to_source_folder
    today = Time.new.strftime('%Y-%m-%d-')
    bones = Bones.new(ARGV)
    ARGV[1] = "test"
    ARGV[2] = "post1"
    bones.listener
    bones.post
    bones.build

    assert "modified absolute path: [Dir.home + /test/source/posts/#{today}-post1.md]", bones.listener
  end
end
