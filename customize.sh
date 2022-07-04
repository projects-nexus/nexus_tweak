SKIPUNZIP=1
MODRM() {
rm -rf $MODPATH/LICENSE 2>/dev/null
rm -rf $MODPATH/README.md 2>/dev/null
rm -rf $MODPATH/changelog.md 2>/dev/null
rm -rf $MODPATH/custom 2>/dev/null
}
MODPRINT() {
memtotalstr=`cat /proc/meminfo | grep MemTotal`
memtotal=${memtotalstr:16:8}
ramsize=`echo "($memtotal / 1048576 ) + 1" | bc`
cat << "EOF"

    _   __                        ______                    __  
   / | / /__  _  ____  _______   /_  __/      _____  ____ _/ /__
  /  |/ / _ \| |/_/ / / / ___/    / / | | /| / / _ \/ __ `/ //_/
 / /|  /  __/>  </ /_/ (__  )    / /  | |/ |/ /  __/ /_/ / ,<   
/_/ |_/\___/_/|_|\__,_/____/    /_/   |__/|__/\___/\__,_/_/|_|  
                                                                
EOF
ui_print ""
sleep 0.3
ui_print "- Device : $(getprop ro.product.model) "
ui_print ""
sleep 0.1
ui_print "- Android Version : $(getprop ro.system.build.version.release) "
ui_print ""
sleep 0.1
ui_print "- CPU Arch : $(getprop ro.bionic.arch) "
ui_print ""
sleep 0.1
ui_print "- SOC : $(getprop ro.board.platform) "
ui_print ""
sleep 0.1
ui_print "- RAM : ${ramsize}GB "
ui_print ""
sleep 0.1
ui_print "- Kernel : $(uname -r) "
ui_print ""
sleep 0.1
ui_print "- SElinux Status : $(su -c getenforce) "
ui_print ""
sleep 0.2
ui_print "- Unlocking The True Power Of $(getprop ro.build.product) "
ui_print ""
sleep 0.3
ui_print "-  Check Internal Storage / Nexus_Tweaks.log For Logs "
sleep 0.3
ui_print ""
}
MODFKM() {
# Moving FKM Script
mkdir -p /data/media/0/franco.kernel_updater/scripts
cp -f $MODPATH/custom/FKM/*.sh /data/media/0/franco.kernel_updater/scripts
}
MODEXTRACT() {
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" module.prop -d $MODPATH >&2
unzip -o "$ZIPFILE" system.prop -d $MODPATH >&2
unzip -o "$ZIPFILE" service.sh -d $MODPATH >&2
unzip -o "$ZIPFILE" all_apps.prop -d $MODPATH >&2
unzip -o "$ZIPFILE" efficient.lst -d $MODPATH >&2
unzip -o "$ZIPFILE" gaming.lst -d $MODPATH >&2
unzip -o "$ZIPFILE" post-fs-data.sh -d $MODPATH >&2
unzip -o "$ZIPFILE" 'custom/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}
MODPERM() {
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/nex 0 2000 0755 0755
set_perm_recursive $MODPATH/system/bin 0 2000 0755 0755
}
set -x
MODPRINT
MODEXTRACT
MODFKM
MODPERM
MODRM
