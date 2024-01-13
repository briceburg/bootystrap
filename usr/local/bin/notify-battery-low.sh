#!/usr/bin/env bash

#
# udev rules will call this script, passing capacity as first argument.
#
# example rule (requires https://raw.githubusercontent.com/Ventto/xpub):
#   ACTION=="change", KERNEL=="BAT[0-9]", SUBSYSTEM=="power_supply", \
#   ATTR{status}=="Discharging", IMPORT{program}="xpub.sh", \
#   RUN+="/usr/bin/su $env{XUSER} -c 'notify-battery-low.sh $attr{capacity}%'"
#

capacity="$1"
f="/tmp/$(basename "$0")"
id=$(cat "$f.id" 2>/dev/null)
last=$(cat "$f.last" 2>/dev/null || echo 100)

notify(){
  notify-send -u "$1" -i battery-empty  -r "${id:-0}" -p "Battery status" "$2 (<b>$capacity%</b>)" > "$f.id"
}

if [ -z "$capacity" ]; then
  notify critical "$(basename "$0") missing capacity argument"
elif [ "$capacity" -le 4 ]; then
  notify critical  "CRITICAL BATTERY LEVEL"
elif [[ "$capacity" -le 66 && $(( last - capacity )) -ge 3 ]]; then
  notify normal  "Battery is getting low"
  echo "$capacity" > "$f.last"
elif [ "$capacity" -gt "$last" ]; then
  rm -f "$f.last"
fi

