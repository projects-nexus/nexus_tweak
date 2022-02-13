#!/system/bin/sh
MODDIR=${0%/*}

# Detect whether Unlocked into System
while $(dumpsys window policy | grep mIsShowing | awk -F= '{print $2}')
do
sleep 1
done

# sleep extra 10s.
sleep 10

su -lp 2000 -c "cmd notification post -S bigtext -t Nexus-Tweaks tag Activated"

# Where It All Begins
nice -n -9 nAi
common > /dev/null

exit 0
