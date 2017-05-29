lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "prawn-rails-forms/version"

Gem::Specification.new do |spec|
  spec.name          = "prawn-rails-forms"
  spec.version       = PrawnRailsForms::VERSION
  spec.authors       = ["UMass Transportation Services"]
  spec.email         = ["transit-it@admin.umass.edu"]
  spec.licenses      = ['MIT']

  spec.summary       = %q{An extension to PrawnRails, making form layouts easier.}
  spec.homepage      = "https://github.com/umts/prawn-rails-forms"
  spec.files         = `git ls-files -z`.split "\x0"
  spec.require_paths = ["lib"]

  spec.add_dependency 'prawn-rails', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
