require 'optparse'

OptionParser.new do |parser|
  parser.banner = "Usage: fish_finder.rb [options]"
  parser.separator ""

  parser.on('--water TYPE', 'Pick "fresh" or "salt"')

  parser.on('-h', '--help', 'Show this message') do
    puts parser
    exit
  end

  parser.on('-v', '--verbose', 'Show fancy fish') do |verbose|
    self.verbose = verbose
  end
end.parse!
