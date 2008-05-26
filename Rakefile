require 'rubygems'
require 'rake/gempackagetask'
load File.dirname(__FILE__) + "/clitt.gemspec"

Rake::GemPackageTask.new($spec) do |pkg|
  pkg.gem_spec = $spec
end

task :install => [:repackage] do
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
