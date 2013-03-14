require 'formula'

class BrewAltTap < Formula
  homepage 'https://github.com/telemachus/homebrew-alttap/'
  url 'git://github.com/telemachus/homebrew-alttap.git'
  version '0.0.3'

  skip_clean 'bin'

  def install
    bin.install 'brew-alt-tap.rb'
    (bin+'brew-alt-tap.rb').chmod 0755
  end
end
