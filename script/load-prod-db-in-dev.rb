#!/usr/bin/env ruby

if ARGV.length != 1
  puts "Usage: #{$0} <dbfile>"
  exit 1
end
original_dbfile = ARGV[0]

require_relative "../config/environment"

unless Rails.env.local?
  abort "This script should only be run in a local development environment."
end

identifier = SecureRandom.hex(4)
tenant = ActiveRecord::FixtureSet.identify(identifier)

path = ApplicationRecord.tenanted_root_config.database_path_for(tenant)
FileUtils.mkdir_p(File.dirname(path), verbose: true)
FileUtils.cp original_dbfile, path, verbose: true

ActiveRecord::Tenanted::DatabaseTasks.migrate_all

ApplicationRecord.with_tenant(tenant) do |tenant|
  Account.sole.destroy!

  Account.create_with_admin_user(
    tenant_id: tenant,
    account_name: "Company #{identifier}",
    owner_name: "Developer #{identifier}",
    owner_email: "dev-#{identifier}@example.com")

  user = User.last
  user.update! password: "secret123456"

  url = Rails.application.routes.url_helpers.root_url(Rails.application.config.action_controller.default_url_options.merge(script_name: Account.sole.slug))
  puts "\n\nLogin to #{url} as #{user.email_address} / #{user.password}"
end
