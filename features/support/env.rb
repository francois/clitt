require "active_support"
require "timecop"
require "fileutils"
require "pathname"
require "spec"
require "pp"

require File.dirname(__FILE__) + "/../../lib/tt"

CLITT_ROOT = Pathname.new(File.expand_path(File.dirname(__FILE__) + "/../.."))
ENV["CLITT_ROOT"] = (CLITT_ROOT + "tmp").to_s
ENV["TZ"] = "UTC"

Before do
  FileUtils.rm_rf("tmp/.tt")
  FileUtils.rm_rf("tmp/projects")
end
