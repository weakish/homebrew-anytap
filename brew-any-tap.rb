# brew-any-tap.rb
# Copy-pasta makes me sad. So let's require 'cmd/tap'.
require 'cmd/tap'
include Homebrew

usage = <<EOF
SYNOPSIS
    brew any-tap [-h|-?|--help] [name URL]

USAGE
    TODO: FIXME
EOF

def raw_install_tap(args)
  dir, url = args[0..1]
  # downcase to avoid case-insensitive filesystem problems
  tapd = validate_name(dir.downcase)

  safe_system('git', 'clone', url, tapd)
  files = []
  tapd.find_formula{ |file| files << tapd.basename.join(file) }
  link_tap_formula(files)
  puts "Tapped #{files.count} formula"
end

def validate_name(name)
  raise "No slashes in tap names." if name =~ %r{/}
  tapd = HOMEBREW_LIBRARY/"Taps/#{name}"
  if tapd.directory?
    raise "Choose another name: a tap #{name} already exists."
  end
  tapd
end

if ARGV.size < 1
  tapd = HOMEBREW_LIBRARY/"Taps"
  tapd.children.each do |tap|
    puts tap.basename.to_s if (tap/'.git').directory?
  end if tapd.directory?
elsif ['-h', '-?', '--help'].include?(ARGV.first)
  puts usage
else
  raw_install_tap(ARGV)
end
