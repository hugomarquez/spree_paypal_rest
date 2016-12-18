$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_paypal_rest/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_paypal_rest"
  s.version     = SpreePaypalRest::VERSION
  s.authors     = ["hugomarquez"]
  s.email       = ["hugomarquez.dev@gmail.com"]
  s.homepage    = "http://www.spreecommerce.com"
  s.summary     = "Adds PayPal Express as a Payment Method to Spree Commerce"
  s.description = "Adds PayPal Express as a Payment Method to Spree Commerce"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.7"
  s.add_dependency "paypal-sdk-rest", "~> 1.6.0"

  s.add_development_dependency "spree", "3.1.3"
  s.add_runtime_dependency "spree_core", '~> 3.1.3'
  s.add_development_dependency "spree_auth_devise", "3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails", ">= 3", "< 5"
  s.add_development_dependency "sass-rails", ">= 4.0", "< 6"
  s.add_development_dependency "coffee-rails", "4.2.1"
  s.add_development_dependency "byebug"
  s.add_development_dependency "thin", "1.6.4"
end
