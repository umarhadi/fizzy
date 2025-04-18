ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include CardTestHelper, ChangeTestHelper, SessionTestHelper

    # FIXME: Remove when upstream in Rails has landed (https://github.com/rails/rails/pull/54938)
    def assert_in_body(text)
      assert_match /#{text}/, @response.body
    end

    # FIXME: Remove when upstream in Rails has landed (https://github.com/rails/rails/pull/54938)
    def assert_not_in_body(text)
      assert_no_match /#{text}/, @response.body
    end
  end
end
