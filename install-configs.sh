#!/bin/bash

function install_packages {
  as_root="$1"
  source_dir="$2"
  dest_dir="$3"
  for package in `ls $source_dir`;
  do
      echo "installing package: $package"
      cmd="stow -d '$source_dir' -t '$dest_dir' --verbose=1 -v '$package'"
      if $as_root ; then
         sudo sh -c "$cmd"
      else
         eval "$cmd"
      fi
  done
}

function install_cronjobs {
  read -p "Install cronjobs? [y/n]: " -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "installing cronjobs"
    crontab ./cron.jobs
  fi
}

install_packages false "config" "$HOME"
install_packages true "root_config" "/"

install_cronjobs
