# frozen_string_literal: true

require_relative "lib/nyt_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "nyt_cli"
  spec.version       = NytCli::VERSION
  spec.authors       = ["Allie Caton"]
  spec.email         = ["alliecaton3@gmail.com"]

  spec.summary       = "Get a list of all the NYT Bestseller Ficition books for a given date, and get more information about each book."
  spec.homepage      = "https://github.com/alliecaton/nyt_bestsellers_CLI"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alliecaton/nyt_bestsellers_CLI"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['nyt-books']
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "colorize"
  spec.add_dependency "launchy"



  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
