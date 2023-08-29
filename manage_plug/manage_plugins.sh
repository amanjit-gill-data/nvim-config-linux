#!/usr/bin/bash

package_path="$HOME/AppData/Local/nvim-data/site/pack/third_party/"
log_file="./pluglog"

# $1 = repo_url
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

  local dir=`basename $1 .git`
  echo -n Installing into ${plugin_type}${dir}...
  echo `date` Install $dir into $plugin_type >> $log_file
  git clone $1 $package_path$plugin_type$dir &>> $log_file
  echo " done."
} 

# $1 = repo_dir
# $2 = --opt|nothing
remove_plugin() {

  if [ "$2" = "--opt" ]; then
    local plugin_type=opt/

  elif [ -z $2 ]; then
    local plugin_type=start/

  else
    echo $2 is not a valid option
    exit 1
  
  fi

  echo -n Removing ${plugin_type}$1...
  echo `date` Remove $1 from $plugin_type >> $log_file
  rm -R -f $package_path$plugin_type$1 &>> $log_file
  echo " done."
}

# $1 = repo_dir|nothing
update_plugins() {

  if [ -z $1 ]; then
    echo loop through all directories

  else
    echo just update $1

  fi
}

# $1 = add|remove|update
# $2 = repo_url|repo_dir  
# $3 = --opt|nothing
case $1 in

  add)
    add_plugin $2 $3;;

  remove)
    remove_plugin $2 $3;;
  
  update)
    update_plugins $2;;

  *)
    echo -e "$1 is not a valid option.\nValid options are add|remove|update.";;
esac



