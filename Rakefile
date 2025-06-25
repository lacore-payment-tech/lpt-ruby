# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "open-uri"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc "Update bundled certs"
task :update_certs do
  cert = URI.open("https://curl.haxx.se/ca/cacert.pem")
  cert_path = File.expand_path("lib/data/ca-certificates.crt", __dir__)
  File.open(cert_path, "w+") do |file|
    file.puts cert.read
  end
end
