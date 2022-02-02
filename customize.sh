SKIPUNZIP=1
MODRM() {
rm -rf $MODPATH/LICENSE 2>/dev/null
rm -rf $MODPATH/README.md 2>/dev/null
}
MODPRINT() {
ui_print "wip"
}
MODEXTRACT() {
ui_print "- Extracting module files"
unzip -o "$ZIPFILE" module.prop -d $MODPATH >&2
unzip -o "$ZIPFILE" system.prop -d $MODPATH >&2
unzip -o "$ZIPFILE" service.sh -d $MODPATH >&2
unzip -o "$ZIPFILE" post-fs-data.sh -d $MODPATH >&2
unzip -o "$ZIPFILE" 'profiles/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}
MODPERM() {
set_perm_recursive $MODPATH 0 0 0755 0644
}
set -x
MODPRINT
MODEXTRACT
MODPERM
MODRM
