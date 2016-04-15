require 'fileutils'
require 'find'
require 'pry'
require 'kramdown'
require 'time'
require 'erb'

class Bones

  def initialize(args)
    @args = ARGV
    @root_path = root_path
    @tag_hash = {}
  end

  def build
    copy_files
    change_md_to_html
    inject_layout_to_all_files
    parse_tags
    reformat_tags_to_snakecase
    create_tag_page
    write_tags_to_page
    puts "Ok you are ready to go!"
  end

  def copy_files
    FileUtils.cp_r((root_path + "source/."), (root_path + "_output"))
  end

  def change_md_to_html
    Dir.glob(root_path + "_output/**/*.md") do |file|
      html_converted = file.sub(".md",".html")
      files = File.read(file)
      kram = Kramdown::Document.new(files).to_html
      File.write(html_converted, kram)
      File.delete(file)
    end
  end

  def inject(path)
    content = File.read(path)
    erb = ERB.new(File.read(root_path + "source/layouts/default.html.erb")).result(binding)
    File.write(path, erb)
  end

  def find_html
    html_files = []
    Find.find(root_path + "/_output") do |path|
      html_files << path if path =~ /.*\.html$/
    end
    html_files
  end

  def parse_tags
    formatted = []
    @md_files = Dir[root_path + "source/posts/*"]
    @md_files.map do |file|
      reading_lines(file)
      if reading_lines(file).length != 0
        tags = reading_lines(file)[1][6..-1].chomp.split(", ")
        tags.each do |tag|
          formatted << tag.gsub(",","")
        end
      end
    end
    @tag_hash["keys:"] = formatted
  end

  def reformat_tags_to_snakecase
    tags = @tag_hash.values
    @reformat = tags.map do |keys|
      @reformatted = keys.map do |tag|
        tag.downcase.gsub(" ", "_")
      end
    end
    @reformatted
  end

  def inject_layout_to_all_files
    find_html.each do |path|
      inject(path)
    end
  end

  def reading_lines(file)
    File.open(file)
    File.readlines(file)
  end

  def post
    today = Time.new.strftime('%Y-%m-%d-')
    file_location = (root_path + "source/posts/#{today}#{@args[2]}.md")
    FileUtils.touch(root_path + "source/posts/#{today}#{@args[2]}.md")
    File.write(file_location, File.read("../lib/example_post.md"))
    puts "You created a new blog post file at: #{file_location}"
  end

  def site_generator
    FileUtils.mkdir_p (root_path + "_output")
    FileUtils.mkdir_p (root_path + "_output/tags")
    FileUtils.mkdir_p (root_path + "source")
    FileUtils.mkdir_p (root_path + "source/css")
    FileUtils.mkdir_p (root_path + "source/pages")
    FileUtils.mkdir_p (root_path + "source/layouts")
    FileUtils.mkdir_p (root_path + "source/posts")
    FileUtils.touch (root_path + "source/css/main.css")
    FileUtils.touch (root_path + "source/layouts/default.html.erb")
    FileUtils.touch (root_path + "source/pages/about.md")
    FileUtils.touch (root_path + "source/index.md")
    FileUtils.touch (root_path + "source/posts/2016-02-20-welcome-to-hyde.md")
    populate_default
    puts "You set up a new blog in the file path #{root_path}"
  end

  def root_path
    Dir.home + "/#{@args[1]}/"
  end

  def populate_default
    populate = File.read("../lib/testdata.html.erb")
    File.write(root_path + "source/layouts/default.html.erb", populate)
  end

  def create_tag_page
    @tag_page = @reformatted.each do |new_files|
      FileUtils.touch(root_path + "_output/tags/" + new_files + ".html").uniq
    end
  end

  def post_files_from_md_to_html
    @converted_posts = @md_files.change_md_to_html
  end

  def write_tags_to_page
    today = Time.new.strftime('%Y-%m-%d-')
      @reformatted.each do |tag|
          File.write(root_path + "_output/tags/#{tag}.html", root_path + "_output/posts/#{today}#{@args[2]}.html")
      end
    end
end
