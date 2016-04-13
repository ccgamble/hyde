require 'fileutils'
require 'find'
require 'pry'
require 'kramdown'


class Bones

  def initialize(args)
    @args = ARGV
  end

  def build
    copy_files
    change_md_to_html
  end

  def copy_files
    FileUtils.cp_r((File.join(Dir.home + "/#{@args[1]}/source/.")), (File.join(Dir.home + "/#{@args[1]}/_output")))
  end

  def change_md_to_html
    Dir.glob(Dir.home + "/#{@args[1]}/_output/**/*.md") do |f|
      html_converted = f.sub(".md",".html")
      files = File.read(f)
      variable = Kramdown::Document.new(files).to_html
      File.write(html_converted, variable)
      File.delete(f)
  end
end

  def site_generator
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/_output"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/css"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/pages"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[1]}/source/posts"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/css/main.css"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/pages/about.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/index.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[1]}/source/posts/2016-02-20-welcome-to-hyde.md"))
  end
end


# bones = Bones.new(ARGV)
# bones.site_generator
# bones.build


#Looks in the source folder and copies the files
#and directories to the output folder. If an
#extension ends with .md, convert it to html
#FileUtils.cp --> unless ends with .md, if it does
#change it to .html

# gather all .md files
# files = Dir.glob(Dir.home + "/#{@args[1]}/source/**/*.md")
# read each file
# files.each do |file|
#     variable = File.read(file)
#     convert using kramdown gem
# change path to _output folder
# file.sub!("source", "_output")
# change extension to .html
# File.write(file, postconverted kramdowntext)
# files = Dir.glob(Dir.home + "/#{@args[1]}/source/**/*.md")
# files.each do |file|
#   markdown_text = File.read(file)
#   html_text = Kramdown::Document.new(markdown_text)
#   file.sub!(Dir.home + "/#{@args[1]}/source/", Dir.home + "/#{@args[1]}/_output/")
# end
# code for changing md to html file
# gsub md to html
# markdown_text = File.read(file)
# html_text = Kramdown::Document.new(markdown_text).to_html


# Dir.glob("/#{@args[1]}/_output/**/*.md") do |f|
#   html_converted = f.gsub(".md",".html")
# end

#Dir.glob("/#{@args[1]}/_output/**/*.md")
# FileUtils.mv f, "#{File.dirname(f)}/#{File.basename(f,'.*')}.html"
