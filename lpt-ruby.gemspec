# frozen_string_literal: true

require_relative "lib/lpt/version"

Gem::Specification.new do |spec|
  spec.name = "lpt-ruby"
  spec.version = Lpt::VERSION
  spec.authors = ["LPT"]
  spec.email = ["support@lpt.io"]

  spec.summary = "LPT Ruby API Client"
  spec.description = "LPT Ruby API Client"
  spec.homepage = "https://lpt.io"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lacore-payment-tech/lpt-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/lacore-payment-tech/lpt-ruby"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 7.0"
  spec.add_dependency "faraday", ">= 2.13.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
