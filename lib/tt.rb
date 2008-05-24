require "fastercsv"
require "pathname"

module Tt
  FORMAT = "%Y-%m-%dT%H:%M"

  def self.tt_dir
    Pathname.new(ENV["HOME"]) + ".tt"
  end

  def self.tt_path
    tt_dir + "entries.csv"
  end

  def self.punch_in(cwd, comment=nil)
    tt_dir.mkdir unless tt_dir.directory?
    FasterCSV.open(tt_path, "ab") do |io|
      io << ["in", cwd, Time.now.utc.strftime(FORMAT), comment]
    end
  end
  
  def self.punch_out(cwd, comment=nil)
    tt_dir.mkdir unless tt_dir.directory?
    File.open(tt_path, "ab") do |io|
      io << ["out", cwd, Time.now.utc.strftime(FORMAT), comment]
    end
  end
end
