require "pathname"
require "time"

module Tt
  FORMAT = "%Y-%m-%dT%H:%MZ"
  SCREEN_FORMAT = "%Y-%m-%d %H:%M"

  def self.csv_engine
    if RUBY_VERSION =~ /^1\.8/ then
      require "fastercsv"
      FasterCSV
    else
      require "csv"
      CSV
    end
  end

  def self.root
    @root ||= ENV["CLITT_ROOT"].to_s.empty? ? ENV["HOME"] : ENV["CLITT_ROOT"]
  end

  def self.tt_dir
    Pathname.new(root) + ".tt"
  end

  def self.tt_path
    tt_dir + "entries.csv"
  end

  def self.punch_in(cwd, comment=nil)
    tt_dir.mkdir unless tt_dir.directory?
    csv_engine.open(tt_path, "ab") do |io|
      io << ["in", cwd, Time.now.utc.strftime(FORMAT), comment]
    end
  end
  
  def self.punch_out(cwd, comment=nil)
    tt_dir.mkdir unless tt_dir.directory?
    csv_engine.open(tt_path, "ab") do |io|
      io << ["out", cwd, Time.now.utc.strftime(FORMAT), comment]
    end
  end

  def self.report_line(dir, intime, outtime, comment, stream=STDOUT)
    ltime = Time.now
    intime = intime + ltime.utc_offset
    endtime = (outtime.nil? ? Time.now.utc : outtime) + ltime.utc_offset
    outtime = outtime + ltime.utc_offset if outtime

    duration_in_seconds = endtime - intime
    duration_in_minutes = duration_in_seconds / 60
    duration_as_human_string = "%02d:%02d" % [duration_in_minutes / 60, duration_in_minutes % 60]

    stream.print "%-40s %16s %16s %5s" % [dir, intime.strftime(SCREEN_FORMAT), outtime ? outtime.strftime(SCREEN_FORMAT) : "", duration_as_human_string]
    stream.print " - %s" % comment if comment && !comment.empty?
    stream.puts
  end

  def self.each_line
    tt_dir.mkdir unless tt_dir.directory?
    line, state, dir, intime, outtime, comment = 0, :out, nil, nil, nil, nil

    csv_engine.foreach(tt_path) do |row|
      line += 1

      case row[0]
      when "in"
        case state
        when :out # punch in
          dir = row[1]
          intime = Time.parse(row[2])
          outtime = nil
          comment = row[3]
          state = :in
        when :in # switch task
          outtime = Time.parse(row[2])
          yield(dir, intime, outtime, [comment, row[3]].compact.join("; "))

          dir = row[1]
          intime = Time.parse(row[2])
          outtime = nil
          comment = nil
        else
          raise ArgumentError, "Unknown processing state: #{state}, expected one of in/out"
        end
      when "out"
        case state
        when :in # punch out
          outtime = Time.parse(row[2])
          yield(dir, intime, outtime, [comment, row[3]].compact.join("; "))

          dir, intime, outtime, comment = nil
          state = :out
        when :out
          $stderr.puts "WARNING: out when already out on line #{line}"
        else
          raise ArgumentError, "Unknown processing state: #{state}, expected one of in/out"
        end
      else
        raise SyntaxError, "Error on line \##{line} of #{tt_path}: unknown reference in column 0: #{row[0]}"
      end
    end if tt_path.file?

    case state
    when :in
      yield(dir, intime, nil, comment)
    end
  end

  def self.report(stream=STDOUT)
    each_line do |dir, intime, outtime, comment|
      report_line(dir, intime, outtime, comment, stream)
    end
  end

  def self.drop
    csv_engine.open(tt_path.to_s + ".new", "wb") do |io|
      lastrow = nil
      csv_engine.foreach(tt_path, "rb") do |row|
        io << lastrow if lastrow
        lastrow = row
      end
    end

    tt_path.unlink
    File.rename(tt_path.to_s + ".new", tt_path)
  end

  def self.clear
    tt_path.unlink
  end
end
