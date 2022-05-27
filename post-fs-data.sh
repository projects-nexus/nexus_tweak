#!/system/bin/sh
MODDIR=${0%/*}

# execute breaker to remove other shit
breaker > /dev/null

exit 0
