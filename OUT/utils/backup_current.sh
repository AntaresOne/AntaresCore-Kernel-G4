#!/sbin/sh
#
# Backup current kernel as flashable zip file
# AntaresOne@JDCTeam
#

BACKUP_DIR=/tmp/utils/backup
BACKUP_MODULES=$BACKUP_DIR/system/lib/
BACKUP_NAME=Kernel-backup.zip
MODULES_DIR=/system/lib/modules
OUT=/data/media/0

if [ ! -e $OUT/$BACKUP_NAME ]; then
    cp /tmp/utils/zip /sbin/ && chmod 0755 /sbin/zip
    dd if=/dev/block/mmcblk0p38 of=$BACKUP_DIR/boot.img
    mkdir -p $BACKUP_DIR/system && mkdir -p $BACKUP_DIR/system/lib
    cp -r $MODULES_DIR $BACKUP_MODULES
    cd $BACKUP_DIR
    zip -r9 $BACKUP_NAME .
    mv $BACKUP_NAME $OUT/
fi
exit 0
