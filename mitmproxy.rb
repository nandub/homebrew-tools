require 'formula'

class Mitmproxy < Formula
  homepage 'http://mitmproxy.org'
  url 'http://mitmproxy.org/download/mitmproxy-0.9.2.tar.gz'
  sha1 '7fa95ef27a4ac5ec85010f4ddb85cf6b7f17ef27'

  depends_on :python
  depends_on 'openssl'

  def install
    python do
      system python, "setup.py", "build"
      system python, "setup.py", "install", "--prefix=#{prefix}"
    end
  end

end
