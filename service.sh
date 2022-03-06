#!/system/bin/sh
MODDIR=${0%/*}

sprop=/data/adb/modules/nexus/system.prop

# Detect whether Unlocked into System
while $(dumpsys window policy | grep mIsShowing | awk -F= '{print $2}')
do
sleep 1
done

# sleep extra 10s.
sleep 10

# excute only once after flashing module
boot=$(getprop nex.boot)

if [ "$boot" == "0" ]; then

# ART optimizer
su -c cmd package bg-dexopt-job

echo nex.boot=1 >> $sprop

fi

su -lp 2000 -c "cmd notification post -S bigtext -t Nexus-Tweaks tag Activated"

# Where It All Begins
nice -n -9 nAi
common > /dev/null

exit 0
