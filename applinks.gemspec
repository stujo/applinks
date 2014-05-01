$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "applinks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "applinks"
  s.version     = Applinks::VERSION
  s.authors     = ["Stuart Jones"]
  s.email       = ["applinks@skillbox.com"]
  s.homepage    = "https://github.com/stujo/applinks"
  s.summary     = "Trying to make it easy to add and use applinks in your webapp"
  s.description = "Description of Applinks."
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.4"
end
