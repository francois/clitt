# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{clitt}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francois Beausoleil"]
  s.date = %q{2009-08-27}
  s.description = %q{Track your time locally, offline, using this simple tool.}
  s.email = %q{francois@teksol.info}
  s.executables = ["clitt", "pi", "po"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README"
  ]
  s.files = [
    "bin/clitt",
     "bin/pi",
     "bin/po",
     "lib/tt.rb",
     "lib/tt/smrty.rb"
  ]
  s.homepage = %q{http://francois.github.com/tt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Track your time locally, offline, using this simple tool.}
  s.test_files = [
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fastercsv>, ["~> 1.2.3"])
    else
      s.add_dependency(%q<fastercsv>, ["~> 1.2.3"])
    end
  else
    s.add_dependency(%q<fastercsv>, ["~> 1.2.3"])
  end
end
