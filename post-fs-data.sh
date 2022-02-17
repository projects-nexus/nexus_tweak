#!/system/bin/sh
module=/data/adb/modules/
conflict=$(find /data/adb -type d -not -path "*modules/nexus*" -iname "*module.prop*")
for nex in $conflict; do
   search=$(echo "$nex" | sed -e 's/\// /g' | awk '{print $4}')
   if grep -q 'tweak' $nex 2>/dev/null; then
     touch $module$search/remove
   fi
done
