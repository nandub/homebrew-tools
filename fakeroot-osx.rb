require "formula"

class FakerootOsx < Formula
  homepage "https://mackyle.github.io/fakeroot/"
  url "https://github.com/downloads/mackyle/fakeroot/fakeroot-macosx-v3.3.tar.gz"
  sha256 "cb42d5f568489baa6d77aa53969bef5403bd5b9b0f3e74e6c4cce5410568c513"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  def install
    system "./bootstrap"
    ENV.append_to_cflags "-pipe -O2 -arch x86_64 -arch i386 -Wno-deprecated-declarations"
    args = %W[
        --disable-dependency-tracking
        --disable-static
        --prefix=#{prefix}
      ]

    system "./configure", *args

    system "make"
    system "make install"
  end
end
