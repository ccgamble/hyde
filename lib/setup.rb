require '../lib/bones'

class Setup

  def run_menu
    if ARGV[0] == "new"
      bones = Bones.new(ARGV)
      bones.site_generator
    else
      "ERROR"
    end
    end
end
