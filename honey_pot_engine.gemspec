require_relative "lib/honey_pot_engine/version"

Gem::Specification.new do |spec|
  spec.name        = "honey_pot_engine"
  spec.version     = HoneyPotEngine::VERSION
  spec.authors     = [ "terao" ]
  spec.email       = [ "" ]
  spec.homepage    = "https://github.com/terao/honey_pot_engine"
  spec.summary     = "Honeypot anti-spam field for Rails forms"
  spec.description = "A lightweight Rails engine that inserts honeypot fields into forms and automatically blocks spammy submissions."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/terao/honey_pot_engine"
  spec.metadata["changelog_uri"]   = "https://github.com/terao/honey_pot_engine/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.2"
end
