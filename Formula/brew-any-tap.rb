require 'formula'

class BrewAnyTap < Formula
  homepage 'https://github.com/telemachus/homebrew-anytap/'
  url 'git://github.com/telemachus/homebrew-anytap.git'
  version '0.0.4'

  skip_clean 'bin'

  def install
    bin.install 'brew-any-tap.rb'
    bin.install 'brew-any-untap.rb'
    (bin+'brew-any-tap.rb').chmod 0755
    (bin+'brew-any-untap.rb').chmod 0755
  end
end
