#!/bin/bash
pinger () {
  ping_cancelled=false
  if [[ $# -lt 2 ]]; then
    echo "more parametres,\nfirst: number == sleep;\nsecond: domain == to ping;"
    return 0
  fi
  pinger () {
    sleep $1
    ping -c1 "$2" >/dev/null 2>&1;
    echo $?
  }

  until [ $(pinger $1 $2) != 2 ]; do echo "."; done
  trap "kill $!; ping_cancelled=true" SIGINT
  wait $!
  trap - SIGINT

  if $ping_cancelled; then
    echo "CANCELED = $ping_cancelled"
  else
      cmatrix
  fi
}
