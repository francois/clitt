When /^it is "([^\"]*)"$/ do |time|
  Timecop.freeze(Time.parse(time).utc)
end

When /^I punch (out|in) from "([^\"]*)"$/ do |action, dirname|
  dir = CLITT_ROOT + "tmp/projects/#{dirname}"
  FileUtils.mkpath(dir)
  Dir.chdir(dir) do
    case action
    when /in/
      Tt.punch_in(Dir.pwd, nil)
    when /out/
      Tt.punch_out(Dir.pwd, nil)
    end
  end
end

When /^(\d+) minutes pass$/ do |mins|
  Timecop.freeze(Time.now.utc + mins.to_i.minutes)
end

Given /^I list my time entries$/ do
  Tt.report(stream = StringIO.new)
  @stdout = stream.string
end

Then /^I should see:$/ do |table|
  entries = @stdout.split("\n").inject([]) do |memo, line|
    if line =~ /^([^\s]+)\s+([-\d]{10})\s+([:\d]{5})\s+(\s+|[-\d]{10})\s+(\s+|[:\d]{5})\s+([:\d]{5}+)(?:\s-\s(.*))?$/ then
      row = [File.basename($1.to_s.strip), $2.to_s.strip, $3.to_s.strip, $4.to_s.strip, $5.to_s.strip, $6.to_s.strip, $7.to_s.strip]
      row.collect! {|str| str.empty? ? nil : str}
      memo << row
    else
      raise ArgumentError, "Could not parse #{line.inspect}"
    end
  end
  table.rows.should == entries
end
