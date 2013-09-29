require 'formula'

class Uthash < Formula
  homepage 'http://troydhanson.github.io/uthash/'
  head 'https://github.com/troydhanson/uthash.git'

  def install
    cd 'src' do
      include.install 'utarray.h', 'uthash.h', 'utlist.h', 'utstring.h'
    end
  end
end
