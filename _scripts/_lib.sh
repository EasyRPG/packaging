#
#
# common lib

player=0
liblcf=0

function get_project() {
  project=$1
  if [ -z "$project" ]; then
    # try directory name
    project=$(basename $PWD)
  fi
  # lowercase
  project=${project,,}

  if [ "$project" == "player" -o "$project" == "easyrpg-player" ]; then
    player=1
  elif [ "$project" == "liblcf" ]; then
    liblcf=1
  else
    echo "project not specified or wrong."
    exit 1
  fi
}

function get_version() {
  [ $player -eq 1 ] && project="Player"
  [ $liblcf -eq 1 ] && project="liblcf"
  if [ -z "$project" ]; then
    echo "project not set"
    exit 1
  fi

  echo `curl -s https://api.github.com/repos/EasyRPG/$project/releases/latest | grep tag_name | sed 's/.*"tag_name": "\([^"]*\)".*/\1/'`
}
