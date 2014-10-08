tiny-linux-bootloader
=====================

A x86 single sector Linux bootloader that can handle initrd.  This bootloader expects to find the kernel immediately after it at sector 1, followed immediately by the initrd.  Any partitions must start after this.

To build, you need to:
1. Edit build.sh and set paths to your kernel + initrd
2. Edit config.inc to set your kernel cmd line (keep it <15chars for the moment, disabling debug makes more room)
3. Run build.sh
4. Now you can dd this onto your disk, if you have a partition table already, then do not overwrite bytes 446-510 on the first sector (so use dd twice).

Your system should now boot with the new kernel.

