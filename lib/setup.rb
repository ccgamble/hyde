require '../lib/bones'
require 'kramdown'

class Setup
  def initialize
    @bones = Bones.new(ARGV)
  end

  def subcommand
    if ARGV[0] == "new"
      @bones.site_generator
    elsif ARGV[0] == "build"
      @bones.build
    elsif ARGV[0] == "post"
      @bones.post
    else
      "ERROR"
    end
  end
end
