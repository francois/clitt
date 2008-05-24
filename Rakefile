require 'rubygems'
require 'rake/gempackagetask'

GEM = "tt"
VERSION = "0.0.1"
AUTHOR = "François Beausoleil"
EMAIL = "francois@teksol.info"
HOMEPAGE = "http://github.com/francois/tt"
SUMMARY = "Track your time locally, offline, using this simple tool."

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  s.add_dependency "fastercsv", "~> 1.2.3"
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,specs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :install => [:package] do
  sh %{sudo gem install --no-rdoc --no-ri pkg/#{GEM}-#{VERSION}}
end

begin
  require "spec/rake/spectask"
rescue LoadError
  raise "rspec ~> 1.1.3 required to spec this gem, but it is not available."
end

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ["--format", "progress", "--color"]
  t.warning = false
end

task :default => :spec
