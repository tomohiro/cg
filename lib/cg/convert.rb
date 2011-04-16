#!/usr/bin/env ruby

require 'date'
require 'fileutils'
require 'pathname'

require 'rubygems'
require 'tilt'
require 'erubis'
require 'rdiscount'
require 'nokogiri'

module CG
  class Convert
    include FileUtils

    def initialize(source)
      @source = source || ARGV.first

      @root = File.expand_path(File.dirname(@source)).gsub('markdown', '')
      @domain = @root.split('/').last

      @templates_dir = templates_dir
    end

    def self.start!(source = nil)
      new(source).start
    end

    def start
      dir_path, html_name = gen_output_path(@source)
      mkdir_p dir_path

      html_path = File.join(dir_path, html_name)
      open(html_path, 'w') do |f|
        @article = article_rendering(load_markdown(@source))
        @relative = (Pathname.new(@root).relative_path_from(Pathname.new(dir_path))).to_s + '/'

        f.write page_build(load_template)
        puts "#{@source} => #{html_path}"
      end
    end

    def gen_output_path(source)
      markdown_base = File.dirname(source)
      expand_path = source.gsub(/-|\+/, '/')

      dir_path = File.expand_path("#{@root}/#{File.dirname(expand_path).gsub(markdown_base, '')}")
      html_name = File.basename(expand_path).gsub('.mkd', '.html')

      [dir_path, html_name]
    end

    def load_template(template_name = 'html.erb')
      Tilt::ErubisTemplate.new { File.read("#{@templates_dir}/#{template_name}") }
    end

    def load_markdown(source)
      Tilt::RDiscountTemplate.new { File.read(source) }
    end

    def templates_dir
      if File.directory? "#{@root}/templates"
        "#{@root}/templates"
      else
        File.expand_path('../../skel/templates', File.dirname(__FILE__))
      end
    end

    def article_rendering(markdown)
      @disqus = comment_rendering

      article = Tilt::ErubisTemplate.new { markdown.render }
      article.render(self)
    end

    def comment_rendering
      return unless File.exist? "#{@templates_dir}/disqus.erb"

      @disqus_subdomain = @domain.gsub('.', '-')

      comment = Tilt::ErubisTemplate.new { File.read("#{@templates_dir}/disqus.erb") }
      comment.render(self)
    end

    def page_build(page)
      @title = [(Nokogiri::HTML(@article)/'h1').text, @domain].join(' - ')

      page.render(self)
    end
  end
end

if __FILE__ == $0
  CG::Convert.start!
end
