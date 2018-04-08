require "simplecov-rcov-text"
require "colorize"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::RcovTextFormatter,
  SimpleCov::Formatter::HTMLFormatter
])

SimpleCov.start do
  add_filter "/spec/"

  # Fail the build when coverage is < 100%:
  at_exit do
    SimpleCov.result.format!
    actual = SimpleCov.result.covered_percent
    if actual < 100 then # FAIL
      msg = "\nLow coverage: "
      msg << "#{actual}%".colorize(:red)
      msg << " is " << "under".colorize(:red) << " the threshold: "
      msg << "#{100}%.".colorize(:green)
      msg << "\n"
      $stderr.puts msg
      exit 1
    else # PASS
      # Precision: three decimal places:
      actual_trunc = (actual * 1000).floor / 1000.0
      msg = "\nCoverage: "
      msg << "#{actual}%".colorize(:green)
      msg << " is " << "at".colorize(:green) << " the threshold: "
      msg << "#{100}%.".colorize(:green)
      msg << "\n"
      $stdout.puts msg
    end
  end
end
