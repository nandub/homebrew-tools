if [ -n "$1" ]; then
  gh_project="github.com/${1}"
else
  gh_project="$(git remote -v | grep '^origin' | grep -oE 'github.com[:/][^/]+/[^/ ]+' | head -1)"
  gh_project="${gh_project%.git}"
fi

url="https://${gh_project/:/\/}/archive/${version}.tar.gz"
