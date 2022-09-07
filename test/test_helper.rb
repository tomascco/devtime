ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start "rails" do
  enable_coverage :branch
end

require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
end
