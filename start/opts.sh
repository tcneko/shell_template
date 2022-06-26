#!/bin/bash

# author: tcneko <tcneko@outlook.com>
# start from: 2022.06
# last test environment: ubuntu 20.04
# description:

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# variable
d_cur="$(dirname ${BASH_SOURCE[0]})"

ccc=""

func_opt_list=(a b c:)
func_opt_long_list=(aaa bbb ccc:)

# function
func_opt_init() {
  for func_opt_long in ${func_opt_long_list[@]}; do
    echo ${func_opt_long} | grep ":$" &>/dev/null
    if (($? != 0)); then
      flag_code=$(echo ${func_opt_long} | tr '-' '_')
      eval opt_flag_${flag_code}=1
    fi
  done
}

safe_start() {

}

help() {
  cat <<EOF

SYNOPSIS
  opts_ready.sh {-h | --help}


OPTIONS
  -h, --help
      Show help information

EOF
}

run_by_flag() {
  if ((${opt_flag_aaa} == 0)); then
    aaa $@
    return $?
  elif ((${opt_flag_bbb} == 0)); then
    bbb $@
    return $?
  fi
}

# main
func_opt_init

func_opt=$(echo ${func_opt_list[@]} | sed 's/ //g')
func_opt_long=$(echo ${func_opt_long_list[@]} | sed 's/ /,/g')
args_temp=$(getopt -o "${func_opt}" -l "${func_opt_long}" -- "$@")
if (($? != 0)); then
  echo_error 'Invalid option'
  exit 1
fi
eval set -- "${args_temp}"
while true; do
  case $1 in
    -h | --help)
      help
      exit 0
      ;;
    -c | -ccc)
      ccc="$2"
      shift
      ;;
    -a | --aaa)
      opt_flag_aaa=0
      ;;
    -b | --bbb)
      opt_flag_bbb=0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo 'Invalid option'
      exit 1
      ;;
  esac
  shift
done

safe_start

run_by_flag $@

exit 0
