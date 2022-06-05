$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "queue_classic_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "queue_classic_admin"
  s.version     = QueueClassicAdmin::VERSION
  s.authors     = ["Simon Mathieu"]
  s.email       = ["simon.math@gmail.com"]
  s.license     = 'MIT'
  s.homepage    = "https://github.com/rainforestapp/queue_classic_admin"
  s.summary     = "An admin interface for QueueClassic"
  s.description = "An admin interface for QueueClassic"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "rails", ">= 5.0.0", "< 7.1"
  s.add_runtime_dependency "queue_classic", "4.0.0"
  s.add_runtime_dependency "pg"
  s.add_runtime_dependency "will_paginate", ">= 3.0.0"
  s.add_runtime_dependency "will_paginate-bootstrap", ">= 0.2.0"

  s.add_development_dependency "sqlite3"
end
