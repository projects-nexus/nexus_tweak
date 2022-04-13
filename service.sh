#!/system/bin/sh
MODDIR=${0%/*}

sprop=/data/adb/modules/nexus/system.prop
nex_log=/storage/emulated/0/Nexus_Tweaks.log

# Universal GMS Doze Module Path
mmodule=/data/adb/modules/universal-gms-doze

# Detect whether Unlocked into System
while $(dumpsys window policy | grep mIsShowing | awk -F= '{print $2}')
do
sleep 1
done

# sleep extra 10s.
sleep 10

NexSTART=$(date +"%s")

echo "- Hello, there! I'm NeX" > $nex_log

echo "" >> $nex_log

echo "- I am here to optimize your $(getprop ro.build.product)" >> $nex_log

echo "" >> $nex_log

# excute only once after flashing module
boot=$(getprop nex.boot)

if [ "$boot" == "0" ]; then

su -lp 2000 -c "cmd notification post -S bigtext -t 'Starting Nexus Tweaks..' tag 'Your device may heat up or lag during optimization.. Please wait..'"

START=$(date +"%s")

echo "- Starting Art Optimization" >> $nex_log

echo "" >> $nex_log

# ART optimizer
su -c cmd package bg-dexopt-job

END=$(date +"%s")

DIFF=$(($END - $START))

echo "- Art Optimization took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)." >> $nex_log

echo "" >> $nex_log

echo nex.boot=1 >> $sprop

if ! [ -d "$mmodule" ]; then

START1=$(date +"%s")

echo "- Starting DUS Optimization" >> $nex_log

echo "" >> $nex_log

# DUS optimizer
dus

END1=$(date +"%s")

DIFF1=$(($END1 - $START1))

echo "- DUS Optimization took $(($DIFF1 / 60)) minute(s) and $(($DIFF1 % 60)) second(s)." >> $nex_log

echo "" >> $nex_log

fi

NexEND=$(date +"%s")

NexDIFF=$(($NexEND - $NexSTART))

NexTime="$(($NexDIFF / 60))-mins-and-$(($NexDIFF % 60))-secs"

su -lp 2000 -c "cmd notification post -S bigtext -t 'Nexus has optimized your device' tag 'It took $NexTime'"

else

su -lp 2000 -c "cmd notification post -S bigtext -t 'Nexus Tweaks' tag 'Activated'"

fi

# execute common tweaks
common > /dev/null

# Where It All Begins
nice -n -9 nAi

exit 0
