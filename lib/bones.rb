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
  end

  def build
    copy_files
    change_md_to_html
    inject_layout_to_all_files
    puts "Ok you are ready to go!"
    parse_tags
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

  def inject_layout_to_all_files
    find_html.each do |path|
      inject(path)
    end
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

  def parse_tags
    today = Time.new.strftime('%Y-%m-%d-')
    content = (root_path + "_output/posts/#{today}post2.html")
    f = File.new(content)
    require 'pry'; binding.pry
    tags = f.readlines[4]
  end

  def root_path
    Dir.home + "/#{@args[1]}/"
  end

  def populate_default
    populate = File.read("../lib/testdata.html.erb")
    File.write(root_path + "source/layouts/default.html.erb", populate)
  end
end
