require 'formula'

class Pkgconf < Formula
  homepage 'https://github.com/pkgconf/pkgconf'
  url 'https://github.com/pkgconf/pkgconf/archive/pkgconf-0.9.6.tar.gz'
  sha256 'aeadf9f35364a78e9a10f800f95e93280f847bd69d36dd69554d7deae72ad0ab'

  depends_on "automake" => :build
  depends_on "autoconf" => :build

  def install
    system "./autogen.sh"
    args = %W[
        --prefix=#{prefix}
      ]

    system "./configure", *args

    system "make"
    system "make install"
  end
end
