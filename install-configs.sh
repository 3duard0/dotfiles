#!/bin/bash

function ask_to_exec {
    msg=$1
    func=${*:2}
    read -p "${msg} [y/n]: " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $func
    fi
}

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
  echo "installing cronjobs"
  crontab ./cron.jobs
}

function install_terminal_profile {
  echo "installing terminal profile"
  dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < terminal-profile.dconf
}

function install_configs {
  install_packages false "config" "$HOME"
  install_packages true "root_config" "/"
}

ask_to_exec "Install configs?" install_configs
ask_to_exec "Install cronjobs?" install_cronjobs
ask_to_exec "Install terminal profile?" install_terminal_profile
