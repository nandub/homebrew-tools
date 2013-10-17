require 'formula'

class Pkgconf < Formula
  homepage 'https://github.com/pkgconf/pkgconf'
  url 'http://rabbit.dereferenced.org/~nenolod/distfiles/pkgconf-0.9.3.tar.bz2'
  sha256 '00033a1080a81dfff7cd7ef98d2b054e4cf627376df92a67b98f2e0c243e7f11'

  def install
    args = %W[
        --prefix=#{prefix}
      ]

    system "./configure", *args

    system "make"
    system "make install"
  end
end
