#! /usr/bin/env bash

function run {
  if ! pgrep -f $1 ; then
    $@&
  fi
}

declare -A commands=(
	["picom"]="-b --experimental-backends"
	["nitrogen"]="--restore"
    ["setxkbmap"]="-layout us -variant altgr-intl"
)

for program in "${!commands[@]}"; do
	run "$program" "${commands[$program]}";
done 

