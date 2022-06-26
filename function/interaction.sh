#!/bin/bash

# author: tcneko <tcneko@outlook.com>
# start from: 2018.08
# last test environment: ubuntu 20.04
# description:

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

# function
echo_info() {
  echo -e "\e[1;32m[Info]\e[0m $@"
}

echo_warning() {
  echo >&2 -e "\e[1;33m[Warning]\e[0m $@"
}

echo_error() {
  echo >&2 -e "\e[1;31m[Error]\e[0m $@"
}

echo_exit() {
  echo_error "$@"
  exit 1
}

request_input() {
  echo "$2"
  eval "read -ep '>>> ' $1"
}

request_yn() {
  prompt_info=$(echo "$1 (y/n)")
  request_input "$prompt_info" cho_yn
}
