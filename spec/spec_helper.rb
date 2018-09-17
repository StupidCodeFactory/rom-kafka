# Loads the code under test
require "rom-kafka"
require "byebug"
# @todo Remove after resolving of mutant PR#444
# @see https://github.com/mbj/mutant/issues/444
Dir['spec/support/**/*.rb'].each { |f| load f }

if ENV["MUTANT"]
  RSpec.configure do |config|
    config.around { |example| Timeout.timeout(0.5, &example) }
  end
end
