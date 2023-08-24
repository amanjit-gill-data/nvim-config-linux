#!/usr/bin/bash

pack_path='~/AppData/Local/nvim-data/site/pack/'
pack_name='third_party'

plugin_path=$pack_path$pack_name

# $1 = plugin name, $2 = --opt or nothing
add_plugin() {
  if [ "$2" = "--opt" ]; then
    # git clone into opt/
  elif [ -z $2 ]; then
    # git clone into start/
  else
    echo "$2 is not a valid option"
  fi
}

update_plugins() {
  echo "update script"
}


case "$1" in
  add)
    add_plugin $2 $3;;
  update)
    echo "you chose update";;
  *)
    echo "no valid option chosen";;
esac



