require 'fileutils'
require 'find'

class Bones

  def initialize(args)
    @args = ARGV
  end

  def build
    #Looks in the source folder and copies the files
    #and directories to the output folder. If an
    #extension ends with .md, convert it to html
    #FileUtils.cp --> unless ends with .md, if it does
    #change it to .html
    Find.find(File.join(Dir.home, "/#{@args[1]}")) do |file|
      if file =~ /.*\.md$/
      # file == Dir.glob("#{@args[1]}/source**/*.md")
        puts "markdown"
      else
        puts "not markdown"
      end
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




bones = Bones.new(ARGV)
bones.site_generator
bones.build
