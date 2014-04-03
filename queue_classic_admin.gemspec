$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "queue_classic_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "queue_classic_admin"
  s.version     = QueueClassicAdmin::VERSION
  s.authors     = ["Simon Mathieu"]
  s.email       = ["simon.math@gmail.com"]
  s.homepage    = "https://github.com/rainforestapp/queue_classic_admin"
  s.summary     = "An admin interface for QueueClassic"
  s.description = "An admin interface for QueueClassic"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "sinatra"
  s.add_dependency "queue_classic", "3.0.0rc"
  s.add_dependency "queue_classic-later"
  s.add_dependency "pg"
  
  s.add_development_dependency "capybara"
  s.add_development_dependency "rspec"
end
