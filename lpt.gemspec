require_relative "lib/lpt/version"

Gem::Specification.new do |spec|
  spec.name        = "lpt"
  spec.version     = LPT::VERSION
  spec.authors     = [ "LPT" ]
  spec.email       = [ "support@lpt.io" ]
  spec.homepage    = "https://lpt.io"
  spec.summary     = "LPT Ruby API Client"
  spec.description = "LPT Ruby API Client"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lacore-payment-tech/lpt-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/lacore-payment-tech/lpt-ruby"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.2.2.1"
  spec.add_dependency "faraday", ">= 2.13.1"
  # gem "httpx"
  # https://honeyryderchuck.gitlab.io/httpx/wiki/Faraday-Adapter
  # https://mattbrictson.com/blog/advanced-http-techniques-in-ruby#aside-faraday-middleware-configuration-pitfalls

  # gem 'faraday-typhoeus' <- curl
  # https://github.com/dleavitt/faraday-typhoeus
end
