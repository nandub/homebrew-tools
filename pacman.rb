require 'formula'

class Pacman < Formula
  homepage 'https://wiki.archlinux.org/index.php/Pacman'
  url 'ftp://ftp.archlinux.org/other/pacman/pacman-4.1.2.tar.gz'
  sha1 'ed9a40a9b532bc43e48680826d57518134132538'

  depends_on 'pkg-config' => :build
  depends_on 'bash'
  depends_on 'libarchive'
  depends_on 'fakeroot'
  depends_on 'openssl'
  depends_on 'curl'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-openssl",
                          "--with-libcurl"
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    This installation of pacman is not configured to install software, so
    commands such as `pacman -Suy`, `pacman -U` etc, etc, will fail.
    EOS
  end
end
