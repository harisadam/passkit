# frozen_string_literal: true

#
# $LOAD_PATH.unshift File.expand_path("../lib", __dir__)
# require "passkit"
#
# require "minitest/autorun"

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require "dotenv/load"
require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"
require "capybara/rails"

Capybara.server = :webrick

# Load fixtures from the engine.
# Rails 7.1+ dropped the singular fixture_path= setter in favor of fixture_paths=;
# support both so this also still runs against the gem's originally supported Rails versions.
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_paths.first + "/files"
  ActiveSupport::TestCase.fixtures :all
elsif ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
