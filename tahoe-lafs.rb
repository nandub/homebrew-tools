require 'formula'

class TahoeLafs < Formula
  homepage 'https://tahoe-lafs.org/trac/tahoe-lafs'
  url 'https://tahoe-lafs.org/source/tahoe-lafs/releases/allmydata-tahoe-1.10.0.zip'
  sha1 'a75e9778ad51d212871ba22013b78813260000f6'

  depends_on :python

  resource 'zfec' do
    url 'https://pypi.python.org/packages/source/z/zfec/zfec-1.4.24.tar.gz'
    sha1 '99b334431209332a14f0531de252aee3de18c948'
  end

  resource 'simplejson' do
    url 'https://pypi.python.org/packages/source/s/simplejson/simplejson-3.3.1.tar.gz'
    sha1 '96df09ecaa489b5600c9f80287ece3657f044719'
  end

  resource 'twisted' do
    url 'https://pypi.python.org/packages/source/T/Twisted/Twisted-13.1.0.tar.bz2'
    sha1 '7f6e07b8098b248157ac26378fafa9e018f279a7'
  end

  resource 'foolscap' do
    url 'https://pypi.python.org/packages/source/f/foolscap/foolscap-0.6.4.tar.gz'
    sha1 'fc705bf300dd54c6d8ec857db39d7aec08760ccb'
  end

  resource 'pyopenssl' do
    url 'https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.13.1.tar.gz'
    sha1 '60633ebb821d48d7132a436c897288ec0121b892'
  end

  resource 'nevow' do
    url 'https://pypi.python.org/packages/source/N/Nevow/Nevow-0.10.0.tar.gz'
    sha1 '134c795581df70649d0c11d8619b8b4e7d3749e6'
  end

  resource 'pycrypto' do
    url 'http://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/pycrypto-2.6.1.tar.gz'
    sha1 'aeda3ed41caf1766409d4efc689b9ca30ad6aeb2'
  end

  resource 'pyasn1' do
    url 'https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.7.tar.gz'
    sha1 'e32b91c5a5d9609fb1d07d8685a884bab22ca6d0'
  end

  resource 'mock' do
    url 'https://pypi.python.org/packages/source/m/mock/mock-1.0.1.tar.gz'
    sha1 'ba2b1d5f84448497e14e25922c5e3293f0a91c7e'
  end

  resource 'pycryptopp' do
    url 'https://pypi.python.org/packages/source/p/pycryptopp/pycryptopp-0.6.0.1206569328141510525648634803928199668821045408958.tar.gz'
    sha1 '773008d41d5c135a5bd899cd4c4a51ee54a97e39'
  end

  # TODO: Move this into Library/Homebrew somewhere (see also ansible.rb).
  def wrap bin_file, pythonpath
    bin_file = Pathname.new bin_file
    libexec_bin = Pathname.new libexec/'bin'
    libexec_bin.mkpath
    mv bin_file, libexec_bin
    bin_file.write <<-EOS.undent
      #!/bin/sh
      PYTHONPATH="#{pythonpath}:$PYTHONPATH" "#{libexec_bin}/#{bin_file.basename}" "$@"
    EOS
  end

  require 'tempfile'
  def prepend(path, string)
    Tempfile.open File.basename(path) do |tempfile|
      # prepend data to tempfile
      tempfile << string
        File.open(path, 'r+') do |file|
        # append original data to tempfile
        tempfile << file.read
        # reset file positions
        file.pos = tempfile.pos = 0
        # copy all data back to original file
        file << tempfile.read
      end
    end
  end

  def install
    install_args = [ "setup.py", "install", "--prefix=#{libexec}" ]

    python do
      resource('zfec').stage { system python, *install_args }
      resource('simplejson').stage { system python, *install_args }
      resource('twisted').stage { system python, *install_args }
      resource('foolscap').stage { system python, *install_args }
      resource('pyopenssl').stage { system python, *install_args }
      resource('nevow').stage { system python, *install_args }
      resource('pycrypto').stage { system python, *install_args }
      resource('pyasn1').stage { system python, *install_args }
      resource('mock').stage { system python, *install_args }
      resource('pycryptopp').stage { system python, *install_args }

      prepend("src/allmydata/__init__.py", "import site; site.addsitedir('#{python.private_site_packages}')\n")

      system python, "setup.py", "sdist"
      system python, "setup.py", "install", "--prefix=#{prefix}"
    end

    Dir["#{bin}/*"].each do |bin_file|
      wrap bin_file, python.site_packages
    end
  end

  def test
    system "#{bin}/tahoe", "--version"
  end
end
