# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sequel/extensions/collation/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Stephens"]
  gem.email         = ["jeremy.f.stephens@vanderbilt.edu"]
  gem.summary       = %q{Sequel extension to access collation information}
  gem.description   = %q{Adds collation information to data returned by a Sequel database's schema method}
  gem.homepage      = "http://github.com/coupler/sequel-collation"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sequel-collation"
  gem.require_paths = ["lib"]
  gem.version       = Sequel::Collation::VERSION

  gem.add_dependency("sequel")
end
