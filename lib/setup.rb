require '../lib/bones'
require 'kramdown'
require 'fileutils'

class Setup
  def initialize
    @bones = Bones.new(ARGV)
  end

  def dir_exists
    existance = (Dir.home + "/#{ARGV[1]}")
    if Dir.exist?(existance) == true && "#{ARGV[0]}" == "new"
        puts "Error, File path already exists"
    else
      subcommand
    end
  end

  def subcommand
    if ARGV[0] == "new"
      @bones.site_generator
    elsif ARGV[0] == "build"
      @bones.build
    elsif ARGV[0] == "post"
      @bones.post
    elsif ARGV[0] == "watchfs"
      @bones.watcher
    else
      "ERROR"
    end
  end
end
