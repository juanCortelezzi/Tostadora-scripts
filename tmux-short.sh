#!/usr/bin/env bash


# this sfind function is aliased on my shellrc
# sfind () {
#   local DIRECTORY=""
#   if [ "$#" -gt 0 ]; then
#     DIRECTORY="$1"
#   fi
#   find $DIRECTORY* \( -path '*/\.*' -o -name node_modules -o -name \.next -o -name libraries -o -name snap -o -name bin -o -name \.git -o -name \.cache -o -name dist -o -name build -o -name Apps -o -name pkg -o -name target \) -prune -o -type d -print -o -type l -print
# }

tsh () {
  ARDDIR=~/Documents/Arduino/
  DEVDIR=~/Documents/Web-programes/
  OLDDIR=$(pwd);

  splitVWindow() {
    vorh=$1
    pane=$2
    shift
    shift
    cmd="tmux split-window -t $pane $vorh -d"
    eval $cmd
  }

  createWindow() {
    session=$1
    window=$2
    shift
    shift
    hasWindow=$(tmux list-windows -t $session | grep "$window")
    if [ -z "$hasWindow" ]; then
      cmd="tmux neww -t $session: -n $window -d"
      if [ $# -gt 0 ]; then
        cmd="$cmd $@"
      fi
      #echo "Creating New Window(\"$hasWindow\"): $cmd"
      eval $cmd
    fi
  }

  createSession() {
    session=$1
    window=$2
    shift
    shift
    cmd="tmux new -s $session -d -n $window $@"
    #echo "Creating Session: $cmd"
    eval $cmd
  }

  while [ "$#" -gt 0 ]; do
    curr=$1
    shift
    case "$curr" in
      "ard")
        cd $ARDDIR
        local NEWDIR=$(sfind | fzf)
        if [[ ! -z $NEWDIR ]]; then
          createSession ard "nvim" -c $ARDDIR$NEWDIR
          createWindow ard "serial" -c $ARDDIR$NEWDIR
          createWindow ard "zsh"
        fi
        ;;
      "dev")
        cd $DEVDIR
        local NEWDIR=$(sfind | fzf)
        if [[ ! -z $NEWDIR ]]; then
          createSession dev "nvim" -c $DEVDIR$NEWDIR
          createWindow dev "srvr1" -c $DEVDIR$NEWDIR
          createWindow dev "srvr2" -c $DEVDIR$NEWDIR
          createWindow dev "zsh"
        fi
        ;;
      "dev2")
        cd $DEVDIR
        local NEWDIR=$(sfind | fzf)
        if [[ ! -z $NEWDIR ]]; then
          createSession dev "front" -c $DEVDIR$NEWDIR
          createWindow dev "back" -c $DEVDIR$NEWDIR
          createWindow dev "srvr1" -c $DEVDIR$NEWDIR
          createWindow dev "srvr2" -c $DEVDIR$NEWDIR
          createWindow dev "zsh"
        fi
        ;;
      "x")
          createSession x "W1"
          createWindow x "W2"
          splitVWindow -h "W2"
        ;;
      "a")
        tmux a
        ;;
      *) echo "Unavailable Command... $curr"
    esac
  done

  if [ $(pwd) != $OLDDIR ]; then
    cd $OLDDIR
  fi
}
