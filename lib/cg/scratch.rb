#!/usr/bin/env ruby

require 'fileutils'

SKEL_PATH = File.expand_path('../../skel', File.dirname(__FILE__))

module CG
  class Scratch
    include FileUtils

    def initialize
      @site = ARGV.first || 'example'
    end

    def self.start!
      new.start
    end

    def start
      mkdir(@site) unless dir_exists?(@site)
      cp_r(Dir.glob(SKEL_PATH + '/{*,.exclude}'), @site)
    end

    def dir_exists?(name)
      begin
        cd(name) { }
        true
      rescue Errno::ENOENT
        false
      end
    end
  end
end

if __FILE__ == $0
  CG::Scratch.start!
end
