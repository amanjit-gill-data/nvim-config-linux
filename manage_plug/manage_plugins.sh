#!/usr/bin/bash

package_path="$HOME/AppData/Local/nvim-data/site/pack/third_party/"
log_file="./pluglog"

# $1 = repo url
get_dir_name() {

  local repo_name=`cut -d / -f 5 <<< $1`  # repo.git

  local end_cut=${#repo_name}             # last index of ".git"
  local start_cut=`expr $end_cut - 3`     # first index of ".git"

  # dir name = cut the ".git" from repo.git
  local dir_name=`cut -c $start_cut-$end_cut --complement <<< $repo_name`
  
  echo $dir_name
}

# $1 = repo url
# $2 = --opt|nothing
add_plugin() {

  if [ "$2" = "--opt" ]; then
    local plugin_type=opt/

  elif [ -z $2 ]; then
    local plugin_type=start/

  else
    echo $2 is not a valid option
    exit 1
  
  fi

  local dir=`get_dir_name $1`
  echo -n Installing into ${plugin_type}${dir}...
  echo `date` Install $dir into $plugin_type >> $log_file
  git clone $1 $package_path$plugin_type$dir &>> $log_file
  echo " done."
} 

# $1 = repo directory name
remove_plugin() {
  echo you chose remove  
}

update_plugins() {
  echo you chose update
}

# $1 = add|update
# $2 = repo url
# $3 = --opt|nothing
case $1 in

  add)
    add_plugin $2 $3;;

  remove)
    echo you chose remove;;
  
  update)
    echo you chose update;;

  *)
    echo no valid option chosen;;
esac



