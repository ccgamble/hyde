require '../lib/bones'
require 'kramdown'

class Setup
  def initialize
    @bones = Bones.new(ARGV)
  end

  def does_dir_exist

  end

  def run_menu
    if ARGV[0] == "new"
      @bones.site_generator
    elsif ARGV[0] == "build"
      @bones.build
    else
      "ERROR"
    end
  end

  def kramdown(file_paths)
    file_paths.map do |source|
      markdown_files = FileList['source/*.markdown']
      Kramdown::Document.new(markdown_files).to_html
    end
  end
end
