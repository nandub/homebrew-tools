this=$(dirname $0)
name=$1

current_version=$(brew info $name | grep $name | awk '{print $3}')
if [ "$version" = "$current_version" ]; then
  echo Nothing to upgrade, version is the same.
else
  exec $this/brew-publish $name $version
fi
