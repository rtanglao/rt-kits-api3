# -*- encoding: utf-8 -*-
# stub: csv 3.1.7 ruby lib

Gem::Specification.new do |s|
  s.name = "csv".freeze
  s.version = "3.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Edward Gray II".freeze, "Kouhei Sutou".freeze]
  s.date = "2020-08-04"
  s.description = "The CSV library provides a complete interface to CSV files and data. It offers tools to enable you to read and write to and from Strings or IO objects, as needed.".freeze
  s.email = [nil, "kou@cozmixng.org".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "NEWS.md".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "NEWS.md".freeze, "README.md".freeze]
  s.homepage = "https://github.com/ruby/csv".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "CSV Reading and Writing".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<benchmark_driver>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<benchmark_driver>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end
