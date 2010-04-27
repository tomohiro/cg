#!/usr/bin/env ruby

$: << File.expand_path(File.dirname(__FILE__))

require 'convert'

module CG
  class Rebuild
    def initialize
      @packaging = ARGV.first || false
    end

    def self.start!
      new.start
    end

    def start
      display 'Rebuild Start.'
      begin
        convert_all
        packaging if @packaging == 'packing'
      rescue
        display 'Rebuild Faild.'
      end
      display 'Rebuild Success.'
    end

    def convert_all
      Dir.glob('markdown/*.mkd').each do |file|
        CG::Convert.start! file
      end
    end

    def packaging
      display '   Packing Start.'
      display `tar zcvf public.tar.gz -X .exclude *`
      display '   Packing End.'
    end

    def display(message)
      puts "#{message}  #{Time.now.to_s}"
    end
  end
end

if __FILE__ == $0
  CG::Rebuild.start!
end
