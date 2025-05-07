require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

desc "Update bundled certs"
task :update_certs do
  require "net/http"
  require "uri"

  fetch_file "https://curl.haxx.se/ca/cacert.pem",
             File.expand_path("lib/data/ca-certificates.crt", __dir__)
end