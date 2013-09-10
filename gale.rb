require 'formula'

class Gale < Formula
  homepage 'http://www.gale.org'
  head 'https://github.com/grawity/gale.git', :branch => 'master'

  depends_on 'bash'
  depends_on 'openssl'
  depends_on 'adns'
  depends_on 'bdw-gc'

  def install
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-iconv",
			  "--enable-adns",
                          "--prefix=#{prefix}"
    ENV.j1 # Or make fails
    system "make"
    system "make install"
  end
end
