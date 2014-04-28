$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "trim/contact-messages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "trim-contact-messages"
  s.version     = Trim::ContactMessages::VERSION
  s.authors     = ["Brett Bender", "Mark Frey", "Patrick Fulton", "Dominic Dagradi"]
  s.email       = ["info@bearded.com"]
  s.homepage    = "http://www.bearded.com"
  s.summary     = "A simple contact form for Trim."
  s.description = "A simple contact form for Trim."
  s.require_paths = ['lib']

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency  'rails',    '~> 3.2.16'
  s.add_dependency  'trim',     '~> 0.6.2'
  s.add_dependency  'rakismet', '~> 1.4.0'

  s.add_development_dependency  'rspec-rails'
  s.add_development_dependency  'capybara'
  s.add_development_dependency  'machinist'
  s.add_development_dependency  'database_cleaner'
  s.add_development_dependency  'colored'   
  s.add_development_dependency  'launchy'
  s.add_development_dependency  'sqlite3'

  s.test_files = Dir["spec/**/*"]

end
