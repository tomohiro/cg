#!/usr/bin/env ruby

require 'rubygems'
require 'rack'

module CG
  class Server
    def initialize
      @file_server = Rack::File.new('.')
    end

    def call(env)
      env['PATH_INFO'] = '/index.html' if  env['PATH_INFO'] == '/'
      puts env['PATH_INFO']

      @file_server.call(env)
    end
  end
end

if __FILE__ == $0
  puts "[#{Time.now.strftime('%Y-%m-%d %H:%m')}] cg server start. http://localhost:9292"
  Rack::Handler::default.run CG::Server.new, :Port => 9292
end
