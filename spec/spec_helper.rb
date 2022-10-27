require 'bundler/setup'
require 'xls_function'
require 'parslet/rig/rspec'
require 'rspec-parameterized'

Dir[File.expand_path('support', __dir__) << '/*.rb'].sort.each { |f| require f }

XlsFunction.verbose = true

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ParserHelper
end
