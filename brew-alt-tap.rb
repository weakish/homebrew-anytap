# brew-alt-tap.rb
# Copy-pasta makes me sad. So let's require 'cmd/tap'.
require 'cmd/tap'

usage = <<EOF
SYNOPSIS
    brew alt-tap <tap>

USAGE
    TODO: FIXME
EOF

if ARGV.size < 1 or ['-h', '-?', '--help'].include?(ARGV.first)
  puts usage
elsif ARGV.include('--raw') or ARGV.include('-r')
  # Use exactly what the user gives us
elsif ARGV.include('--private') or ARGV.include('-p')
  # A private repo means we shouldn't check for existence via curl
else
  puts "Proof of Concept"
end

