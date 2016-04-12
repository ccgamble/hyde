require '../lib/bones'

class Setup

  attr_reader :bones

  def initialize
    @bones = Bones.new
  end

  def run_menu
    ARGV[0]
    if "new"
      bones.site_generator
    else
      "error"
    end
  end
end
