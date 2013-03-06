# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cg/version'

Gem::Specification.new do |gem|
  gem.name          = "cg"
  gem.version       = Cg::VERSION
  gem.authors       = ["Tomohiro, TAIRA"]
  gem.date          = %q{2010-06-04}
  gem.email         = ["tomohiro.t+github@gmail.com"]
  gem.description   = %q{cg is A Ruby based contents generator}
  gem.summary       = %q{HTML Contents Generator}
  gem.homepage      = "http://rubygems.org/gems/cg"
  gem.required_rubygems_version = Gem::Requirement.new(">= 0") if gem.respond_to? :required_rubygems_versions=

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.extra_rdoc_files = [
    "LICENSE",
    "README.mkd"
  ]
  gem.rdoc_options = ["--charset=UTF-8"]
  gem.rubygems_version = %q{1.3.6}
  gem.test_files = [
    "spec/cg_spec.rb",
    "spec/spec_helper.rb"
  ]

  if gem.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    gem.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      gem.add_runtime_dependency(%q<rack>, [">= 1.1.0"])
      gem.add_runtime_dependency(%q<tilt>, [">= 0.9"])
      gem.add_runtime_dependency(%q<erubis>, [">= 2.6.5"])
      gem.add_runtime_dependency(%q<nokogiri>, [">= 1.4.1"])
      gem.add_runtime_dependency(%q<rdiscount>, [">= 1.6.3.1"])
      gem.add_development_dependency(%q<rspec>, ["1.2.9"])
    else
      gem.add_dependency(%q<rack>, [">= 1.1.0"])
      gem.add_dependency(%q<tilt>, [">= 0.9"])
      gem.add_dependency(%q<erubis>, [">= 2.6.5"])
      gem.add_dependency(%q<nokogiri>, [">= 1.4.1"])
      gem.add_dependency(%q<rdiscount>, [">= 1.6.3.1"])
      gem.add_dependency(%q<rspec>, ["1.2.9"])
    end
  else
    gem.add_dependency(%q<rack>, [">= 1.1.0"])
    gem.add_dependency(%q<tilt>, [">= 0.9"])
    gem.add_dependency(%q<erubis>, [">= 2.6.5"])
    gem.add_dependency(%q<nokogiri>, [">= 1.4.1"])
    gem.add_dependency(%q<rdiscount>, [">= 1.6.3.1"])
    gem.add_dependency(%q<rspec>, ["1.2.9"])
  end
end
