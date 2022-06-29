# frozen_string_literal: true

require_relative 'lib/kobana_pix/version'

Gem::Specification.new do |spec|
  spec.name = 'kobana_pix'
  spec.version = KobanaPix::VERSION
  spec.authors = ['Bruno Meira']
  spec.email = ['bruno.meiramelhado@gmail.com']

  spec.summary = 'Kobana Pix'
  spec.description = 'Create Pix with Kobana API'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'
  spec.metadata['source_code_uri'] = 'https://developers.kobana.com.br/v2.0/reference/post_v2-charge-pix'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
