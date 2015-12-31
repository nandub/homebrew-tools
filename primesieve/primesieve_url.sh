get_latest_version() {
  wget -q -O- 'http://primesieve.org/downloads/' | \
  sed -n 's,.*primesieve-\([0-9][^>]*\)\.tar.*,\1,p' | \
  grep -v '\(linux\|mac\|win\)' | \
  sort -r | \
  head -1
}
export version=$(get_latest_version)
export url="https://dl.bintray.com/kimwalisch/primesieve/primesieve-${version}.tar.gz"
