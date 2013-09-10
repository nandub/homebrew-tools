require 'formula'

class Darwinbuild < Formula
  homepage 'http://darwinbuild.macosforge.org'
  if MacOS.version >= :snow_leopard
    url 'http://svn.macosforge.org/repository/darwinbuild/trunk/'
  elsif MacOS.version = :leopard
    url 'http://svn.macosforge.org/repository/darwinbuild/releases/Darwin9/'
  end
  version '0.1.0'

  depends_on :xcode

  def install
    system "xcodebuild", "-configuration", "Release", "DSTROOT=/", "PREFIX=#{prefix}", "ONLY_ACTIVE_ARCH=YES", "install"
  end
end
