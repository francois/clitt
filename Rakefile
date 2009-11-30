begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name              = "clitt"
    s.summary           = "Track your time locally, offline, using this simple tool."
    s.email             = "francois@teksol.info"
    s.homepage          = "http://francois.github.com/tt"
    s.description       = s.summary
    s.authors           = "Francois Beausoleil"
    s.has_rdoc          = false

    s.files             = FileList["bin/*"] + FileList["lib/**/*"]

    s.add_runtime_dependency "fastercsv", "~> 1"

    s.add_development_dependency "active_support"
    s.add_development_dependency "timecop"
    s.add_development_dependency "rspec"
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
