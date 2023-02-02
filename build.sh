#!/bin/sh -e

INPUT="bsect.asm"
OUTPUT="disk"
KERN="./barebone"
RD="./big.init"

#size of kern + ramdisk
K_SZ=$(stat -c %s $KERN)
R_SZ=$(stat -c %s $RD)

#padding to make it up to a sector
K_PAD=$((512 - K_SZ % 512))
R_PAD=$((512 - R_SZ % 512))

nasm -o $OUTPUT -D initRdSizeDef="$R_SZ $INPUT"
cat $KERN >> $OUTPUT
if [ $K_PAD -lt 512 ]; then
dd if=/dev/zero bs=1 count=$K_PAD >> $OUTPUT
fi
cat $RD >> $OUTPUT
if [ $R_PAD -lt 512 ]; then
dd if=/dev/zero bs=1 count=$R_PAD >> $OUTPUT
fi

TOTAL=$(stat -c %s $OUTPUT)
printf "concatenated bootloader, kernel and initrd into ::> %s\n" "$OUTPUT"
printf "Note, your first partition must start after sector %s\n" "$((TOTAL / 512))"



