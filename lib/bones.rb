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
    inject
  end

  def copy_files
    FileUtils.cp_r((File.join(Dir.home + "/#{@args[1]}/source/.")), (File.join(Dir.home + "/#{@args[1]}/_output")))
  end

  def change_md_to_html
    Dir.glob(Dir.home + "/#{@args[1]}/_output/**/*.md") do |file|
      html_converted = file.sub(".md",".html")
      files = File.read(file)
      kram = Kramdown::Document.new(files).to_html
      # inject
      File.write(html_converted, kram)
      File.delete(file)
  end
end

  def inject
    content = File.read(Dir.home + "/#{@args[1]}/_output/posts/2016-04-14-post1.html")
    #eenum?
    erb = ERB.new(File.read(Dir.home + "/#{@args[1]}/source/layouts/default.html.erb")).result(binding)
    File.write(Dir.home + "/#{@args[1]}/_output/posts/2016-04-14-post1.html", erb)
  end

  def post
    today = Time.new.strftime('%Y-%m-%d-')
    file_location = (root_path + "source/posts/#{today}#{@args[2]}.md")
    FileUtils.touch(root_path + "source/posts/#{today}#{@args[2]}.md")
    puts "You created a new blog post file at: #{file_location}"
    File.write(file_location, "#Yo, this is some sample stuff. \n\n You need to blog some real stuff \n\n Yup")
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

  def root_path
    Dir.home + "/#{@args[1]}/"
  end

  def populate_default
    populate = File.read("../lib/testdata.html.erb")
    File.write(root_path + "source/layouts/default.html.erb", populate)
  end
end
