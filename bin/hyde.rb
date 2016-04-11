#!/usr/bin/env ruby
require 'fileutils'

args = ARGV

puts "You ran Hyde with these arguments: #{args}"

FileUtils.mkdir_p "../../../../#{args[0]}/_output"
# FileUtils.mkdir_p '../lib/source'
# FileUtils.mkdir_p '../lib/source/css'
# FileUtils.mkdir_p '../lib/source/pages'
# FileUtils.mkdir_p '../lib/source/posts'
# FileUtils.touch '../lib/source/css/main.css'
# FileUtils.touch '../lib/source/pages/about.md'
# FileUtils.touch '../lib/source/index.md'
# FileUtils.touch '../lib/source/posts/2016-02-20-welcome-to-hyde.md'


# when this file is run the skeleton for the blog is made.
# in order to create file we need commands that create files and directories.
# "FILE.new stuff"
# if folder exists --> throw an error. (conditional statement needed)
#
#
#
