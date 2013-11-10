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
  gem.summary       = %q{modify parts of a hash using a key_path. Works with Rails and Ruby}
  gem.homepage      = "https://github.com/nicolai86/url_plumber"
  gem.license       = "MIT"

  gem.files         = Dir["{app,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = Dir["test/**/*"]
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport', '>= 3.0.0'
  gem.add_development_dependency 'rake', '~> 10.0.3'

  # signing key and certificate chain
  # gem.signing_key = 'gem-private_key.pem'
  # gem.cert_chain  = ['gem-public_cert.pem']
end
