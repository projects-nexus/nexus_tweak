#!/system/bin/sh
# NeXus Tweaks

# Improve boot time by tuning I/O scheduler parameters (Cherrypicked from https://source.android.com/devices/tech/perf/boot-times)
 write "/sys/block/sda/queue/iostats" "0"
 write "/sys/block/sda/queue/scheduler" "cfq"
 write "/sys/block/sda/queue/iosched/slice_idle" "0"
 write "/sys/block/sda/queue/read_ahead_kb" "2048"
 write "/sys/block/sda/queue/nr_requests" "256"
 write "/sys/block/dm-0/queue/read_ahead_kb" "2048"
 write "/sys/block/dm-1/queue/read_ahead_kb" "2048"