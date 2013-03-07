#!/usr/bin/env ruby

CG_LIB = "#{CG_ROOT}/lib/cg"

require 'optparse'

class ContentsGenerator
  def initialize
    @command = ARGV.shift
    @argv = ARGV
    @commands = get_commands
  end

  def self.boot
    new.switch
  end

  def switch 
    if @commands.include? @command
      exec("ruby #{CG_LIB}/#{@command}.rb #{@argv.join(' ')}")
    else
      puts OptionParser.new("Usage: cg [#{@commands.join('|')}]").help
    end
  end

  def get_commands
    commands = []
    Dir.entries(CG_LIB).each do |file|
      commands << file.gsub!('.rb', '') if file =~ /rb/ and file != 'version.rb'
    end
    commands
  end
end
