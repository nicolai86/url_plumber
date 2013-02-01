# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_plumber/version'

Gem::Specification.new do |gem|
  gem.name          = "url_plumber"
  gem.version       = UrlPlumber::VERSION
  gem.authors       = ["Raphael Randschau"]
  gem.email         = ["nicolai86@me.com"]
  gem.description   = %q{modify parts of a hash using a key_path}
  gem.summary       = %q{modify parts of a hash using a key_path}
  gem.homepage      = "https://github.com/nicolai86/url_plumber"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport', '>= 3.0.0'
  gem.add_development_dependency 'rake', '~> 10.0.3'
end
