# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tz_lookup_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "tz_lookup_wrapper"
  spec.version       = TzLookupWrapper::VERSION
  spec.authors       = ["Rajitha Perera"]
  spec.email         = ["rajiteh@gmail.com"]
  spec.summary       = %q{Ruby wrapper for tz-lookup npm package.}
  spec.homepage      = "https://github.com/rajiteh/tz_lookup_wrapper"
  spec.license       = "CC0"

  spec.files         = `git ls-files -z`.split("\x0")

  # http://somethingaboutcode.wordpress.com/2012/09/27/include-files-from-git-submodules-when-building-a-ruby-gem/
  # get an array of submodule dirs by executing 'pwd' inside each submodule
  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ""
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
