require 'formula'

class Mitmproxy < Formula
  homepage 'http://mitmproxy.org'
  url 'http://mitmproxy.org/download/mitmproxy-0.9.1.tar.gz'
  sha1 'c0acfce33d5fef04987a789ad145dc72b576be3c'

  depends_on :python
  depends_on 'openssl'

  def install
    python do
      system python, "setup.py", "build"
      system python, "setup.py", "install", "--prefix=#{prefix}"
    end
  end

end
