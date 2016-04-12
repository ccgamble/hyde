require 'fileutils'
class Bones

  def initialize(args)
    @args = ARGV
  end

  def site_generator
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[0]}/_output"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[0]}/source"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[0]}/source/css"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[0]}/source/pages"))
    FileUtils.mkdir_p (File.join(Dir.home, "/#{@args[0]}/source/posts"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[0]}/source/css/main.css"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[0]}/source/pages/about.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[0]}/source/index.md"))
    FileUtils.touch (File.join(Dir.home, "/#{@args[0]}/source/posts/2016-02-20-welcome-to-hyde.md"))
  end
end


# bones = Bones.new(ARGV)
# bones.site_generator