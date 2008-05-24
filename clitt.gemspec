GEM = "tt"
VERSION = "0.0.1"
AUTHOR = "François Beausoleil"
EMAIL = "francois@teksol.info"
HOMEPAGE = "http://github.com/francois/tt"
SUMMARY = "Track your time locally, offline, using this simple tool."

$spec = Gem::Specification.new do |s|
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
  s.files = %w(LICENSE README Rakefile TODO lib/tt.rb)
end
