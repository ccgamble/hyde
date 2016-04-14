require 'fileutils'
require 'find'
require 'pry'
require 'kramdown'
require 'time'
require 'erb'

class Bones

  def initialize(args)
    @args = ARGV
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
      variable = Kramdown::Document.new(files).to_html
      File.write(html_converted, variable)
      File.delete(file)
  end
end

  def inject
      Dir.glob(Dir.home + "/#{@args[1]}/_output/**/*.html") do |something|
        file_test = File.read(something)
        ERB.new(file_test).result
    end
  end

  def post
    today = Time.new.strftime('%Y-%m-%d-')
    file_location = (File.join(Dir.home, "/#{@args[1]}/source/posts/#{today}#{@args[2]}.md"))
    FileUtils.touch((File.join(Dir.home, "/#{@args[1]}/source/posts/#{today}#{@args[2]}.md")))
    puts "Created a new post file at: #{file_location}"
    File.write(file_location, "Yo, this is some sample stuff, you need to blog some real stuff")
  end

  def site_generator
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/_output"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/css"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/pages"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/layouts"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/posts"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/css/main.css"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/layouts/default.html.erb"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/pages/about.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/index.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/posts/2016-02-20-welcome-to-hyde.md"))
  end
end
