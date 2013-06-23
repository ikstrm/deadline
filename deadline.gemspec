# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deadline/version'

Gem::Specification.new do |spec|
  spec.name          = "deadline"
  spec.version       = Deadline::VERSION
  spec.authors       = ["ikstrm"]
  spec.email         = ["kokubun.t.aa@m.titech.ac.jp"]
  spec.description   = %q{Manage deadlines of your tasks and show timer for you}
  spec.summary       = %q{Manage deadlines of your tasks}
  spec.homepage      = "https://github.com/ikstrm/deadline"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["deadline"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "active_support"
  spec.add_dependency "i18n"
  spec.add_dependency "terminal-notifier", '~> 1.4'
  spec.add_dependency "ruby-growl"
end
