#!/usr/bin/env ruby

require 'fileutils'

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

      open(File.join(dir_path, html_name), 'w') do |f|
        @article = article_rendering(load_markdown(@source))
        @relative = relative_path(dir_path)

        f.write page_build(load_template)
      end
    end

    def gen_output_path(source)
      markdown_base = File.dirname(source)
      expand_path = source.gsub(/-|\+/, '/')

      dir_path = File.expand_path("#{@root}/#{File.dirname(expand_path).gsub(markdown_base, '')}")
      html_name = File.basename(expand_path).gsub('.mkd', '.html')

      [dir_path, html_name]
    end

    def relative_path(dir_path)
      point = dir_path.gsub(@root, '').split('/').count
      '../' * point
    end

    def load_template(template_name = 'html.rb')
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
      return unless File.exist? "#{@templates_dir}/disqus.rb"

      @disqus_subdomain = @domain.gsub('.', '-')

      comment = Tilt::ErubisTemplate.new { File.read("#{@templates_dir}/disqus.rb") }
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
