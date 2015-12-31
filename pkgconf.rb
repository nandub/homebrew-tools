require 'formula'

class Pkgconf < Formula
  homepage 'https://github.com/pkgconf/pkgconf'
  url "https://github.com/pkgconf/pkgconf/archive/pkgconf-0.9.12.tar.gz"
  sha256 "d31a19e22908e5bf277454261222da0640115844f7a62672dbe9e92061d547c5"

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
