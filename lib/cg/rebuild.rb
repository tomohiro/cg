#!/usr/bin/env ruby

$: << File.expand_path(File.dirname(__FILE__))

require 'convert'

module CG
  class Rebuild
    def initialize
    end

    def self.start!
      new.start
    end

    def start
    end
  end
end

if __FILE__ == $0
  CG::Rebuild.start!
end
