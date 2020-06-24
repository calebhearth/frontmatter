$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "frontmatter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "frontmatter"
  spec.version     = Frontmatter::VERSION
  spec.authors     = ["Caleb Hearth"]
  spec.email       = ["caleb@calebhearth.com"]
  spec.homepage    = "https://github.com/calebthompson/frontmatter"
  spec.summary     = "Semi-static pages with data in Rails."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.files = Dir["{app,config,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "railties"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "rails"
  spec.add_development_dependency "pg"
end
