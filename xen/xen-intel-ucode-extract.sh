#!/bin/bash -e

UCODE_RD="/boot/intel-ucode.img"
XEN_EFI_UCODE="/boot/xen-efi-intel-ucode.bin"
UCODE_ORIG_BIN="kernel/x86/microcode/GenuineIntel.bin"

# remove old file
if [ -f $XEN_EFI_UCODE ]; then
	rm $XEN_EFI_UCODE
fi

# create new file
if [ -f $UCODE_RD ]; then
	bsdtar -Oxf $UCODE_RD $UCODE_ORIG_BIN > $XEN_EFI_UCODE || exit 1
fi


exit 0
