Gem::Specification.new do |gem|
  gem.name             = "rom-kafka"
  gem.version          = "0.1.0"
  gem.author           = ["Andrew Kozin"]
  gem.email            = ["andrew.kozin@gmail.com"]
  gem.summary          = "Kafka support for Ruby Object Mapper"
  gem.description      = gem.summary
  gem.homepage         = "https://rom-rb.org"
  gem.license          = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables      = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]
  gem.require_paths    = ["lib"]

  gem.add_runtime_dependency "rom", "~> 4.2.1"
  gem.add_runtime_dependency "ruby-kafka", "~> 0.6.8"
  gem.add_runtime_dependency "concurrent-ruby", "~> 1.0.5"

  gem.add_development_dependency "dry-inflector", "~> 0.1.2"
  gem.add_development_dependency "timecop", "~> 0.9.1"
  gem.add_development_dependency "rspec", "~> 3.8.0"
  gem.add_development_dependency "byebug", "~> 10.0.2"
  gem.add_runtime_dependency     "rom-sql"
end
