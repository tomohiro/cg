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
      @site_base_path = File.expand_path(File.dirname(@source)).gsub('markdown', '')
    end

    def self.start!(source = nil)
      new(source).start
    end

    def start
      dir_path, html_name = gen_output_path(@source)

      template = load_template
      @article = article_rendering(load_markdown(@source))

      mkdir_p dir_path

      open(File.join(dir_path, html_name), 'w') do |f|
        f.write page_build(template)
      end
    end

    def gen_output_path(source)
      markdown_base = File.dirname(source)
      expand_path = source.gsub(/-|\+/, '/')

      dir_path = File.expand_path("#{@site_base_path}/#{File.dirname(expand_path).gsub(markdown_base, '')}")
      html_name = File.basename(expand_path).gsub('.mkd', '.html')

      [dir_path, html_name]
    end

    def load_template(template_name = 'html.rb')
      Tilt::ErubisTemplate.new do
        File.read("#{@site_base_path}/template/#{template_name}")
      end
    end

    def load_markdown(source)
      Tilt::RDiscountTemplate.new { File.read(source) }
    end

    def article_rendering(markdown)
      @disqus_subdomain = @site_base_path.split('/').last.gsub('.', '-')
      @disqus = disqus_template

      article = Tilt::ErubisTemplate.new { markdown.render }
      article.render(self)
    end

    def page_build(page)
      @title = [(Nokogiri::HTML(@article)/'h2').text, (Nokogiri::HTML(@article)/'h1').text].join(' - ')

      page.render(self)
    end

    def disqus_template
      return unless File.exist? "#{@site_base_path}/template/disqus.rb"
      disqus = Tilt::ErubisTemplate.new { File.read("#{@site_base_path}/template/disqus.rb") }
      disqus.render(self)
    end
  end
end

if __FILE__ == $0
  CG::Convert.start!
end
