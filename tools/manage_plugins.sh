#!/usr/bin/bash

package_path="$HOME/AppData/Local/nvim-data/site/pack/third_party/"
log_file="$PWD/plugin_log" 

# if --opt, installs plugin into opt/; otherwise installs into start/
# $1 = repo_url
# $2 = --opt | nothing
add_plugin() {

  if [ "$2" = "--opt" ]; then
    local parent_dir=opt/

  elif [ -z $2 ]; then
    local parent_dir=start/

  else
    echo "Invalid option: $2"
    exit 1
  
  fi

  local dir=`basename $1 .git`
  echo -n Installing into $parent_dir$dir...
  echo `date` Install $dir into $parent_dir >> $log_file
  git clone --quiet $1 $package_path$parent_dir$dir &>> $log_file
  echo " done."
} 

# removes all copies of plugin found in start/ and /opt
# $1 = repo_dir
remove_plugin() {

  cd $package_path
  find . -mindepth 2 -maxdepth 2 -name $1 | while read repo; do
    repo=${repo:2} # cut off the ./ to tidy log text 
    echo -n Removing $repo...
    echo `date` Remove $repo >> $log_file
    cd `dirname $repo`
    rm -R -f $1 &>> $log_file
    echo " done."
  done
}

# if no args, updates all plugins found in start/ and /opt
# if plugin name provided, updates all copies of plugin found in start/ and /opt
# $1 = repo_dir | nothing
update_plugins() {

  if [ -z $1 ]; then

    cd $package_path
    find . -mindepth 2 -maxdepth 2 -type d | while read repo; do
      update_one $repo
    done
    
  else

    cd $package_path
    find . -mindepth 2 -maxdepth 2 -name $1 | while read repo; do
      update_one $repo
    done

  fi
}

# $1 = ./parent_dir/repo_dir
update_one() {
 
      repo=${1:2} # cut off the ./ to tidy log text 
      echo -n Updating $repo...
      echo `date` Update $repo >> $log_file
      cd $package_path$repo
      git pull &>> $log_file
      echo " done."
}

# $1 = add|remove|update
# $2 = repo_url|repo_dir  
# $3 = --opt|nothing
case $1 in

  add)
    add_plugin $2 $3;;

  remove)
    remove_plugin $2;;
  
  update)
    update_plugins $2;;

  *)
    echo "Invalid argument: $1"

esac



