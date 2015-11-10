$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rd_to_salesforce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rd_to_salesforce"
  s.version     = RdToSalesforce::VERSION
  s.authors     = ["Gabriel Nogueira"]
  s.email       = ["gfnogueira@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RdToSalesforce."
  s.description = "TODO: Description of RdToSalesforce."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "databasedotcom"
  s.add_dependency "databasedotcom-rails"
end
