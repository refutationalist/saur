# The Xen Suite

> [!TIP]
> It is recommended to build all Xen packages in a clean chroot or VM.  The build processes can pick up unintended dependencies.

All packages (save xen-next) are required for full functionality.  There are optional build-time flags for some packages but are not recommended unless you know what you're doing.  The xen-aur package is the xen package [as it appears in AUR](https://aur.archlinux.org/packages/xen).

For operational information about Xen on Arch Linux, see [the Xen wiki page](https://wiki.archlinux.org/title/Xen) on the Arch Wiki.


## Building Xen

The ``xen`` package follows the stable git branch (``stable-4.20`` as of March 2025) rather than the release tarball, following Xen security team best-practices.  The PKGBUILD is split and will create the main ``xen`` package and a ``xen-docs`` documentation package.  If stubdom is enabled, a ``xen-stubdom`` package will be built.

Xen is a split package, and there are several options to building Xen:

  1) ``build_stubdom`` -- Build the components to run Xen stubdoms, mainly for [dom0 disaggregation](https://wiki.xenproject.org/wiki/Dom0_Disaggregation).  Components for stubdom are broken off into ``xen-stubdom`` if built.  Defaults to false.
  2) ``boot_dir``-- Your boot directory.  Defaults to ``/boot``.
  3) ``efi_dir``, ``efi_mountpoint`` -- Your EFI directory and mountpoint.   Defaults to ``/boot``.

Pass these arguments to makepkg as variables:

```
$ build_stubdom=true efi_dir="/boot/EFI" makepkg
```

If you build stubdom, note that it brings in a number of other components.   


## QEMU for Xen

By itself, the ``xen`` package can run PVH domUs without graphical consoles and with only Xen paravirtualized interfaces.   For anything else, a special version of QEMU is required.

Xen support in QEMU has been upstreamed but the support isn't compiled into the QEMU in the Arch repositories.   This package adds that support, and is designed not to interfere with the QEMU in ```[extra]```.

## Booting domUs

In Xen parlance the hypervisor is called the **dom0**, and any virtual machine is a **domU**.

There are several methods of virtualization for Xen domUs:

  * PV (paravirtualization) is the original mode in Xen.
  * HVM virtualizes a complete computer with BIOS or UEFI and uses hardware virtualization extensions.
  * PVH is a paravirtualized machine inside of hardware virtualization.   Technically PVHv2, this method of virtualization provides a smaller attack surface and is under much development.   It does not yet support all features.

The boot HVM machines, you can boot BIOS or UEFI systems.   For BIOS, install [seabios](https://archlinux.org/packages/extra/any/seabios/).  To boot UEFI, ```xen-edk2``` is needed.

For PV and PVH machines, you'll need GRUB compiled specifically for that mode.   Alternatively, you can also pass a specific kernel to boot on the ```kernel``` config line, but that means the kernel has to exist outside of the domU.

### xen-grub

This is a split package which has each version of GRUB in an individual package.

| Package | Mode | Build Flag | ```kernel``` Entry |
|---------|------|------------|--------------------|
| ```xen-grub-pvh``` | PVH | ```build_pvh``` | ``/usr/lib/xen/boot/pvhgrub`` |
| ```xen-grub-pv32``` | 32bit PV | ```build_pv32``` | ``/usr/lib/xen/boot/pvgrub32`` |
| ```xen-grub-pv64``` | 64bit PV | ```build_pv64``` | ``/usr/lib/xen/boot/pvgrub64`` |

By default, all three packages are built.

Put the resulting file in the ```kernel``` line of your domU config, and GRUB will look for the standard grub.cfg line and try to boot appropriately.

> [!WARNING]
> PV GRUB does not understand Zstd kernel compression, which means it can't boot stock Arch Linux kernels.  An uncompressed kernel can be created using the ```extract_vmlinux``` script found in the ```linux-headers``` package.   A potential pacman hook is in the works, but should be easy to figure out.  PVH GRUB does not have this issue.


## Future Plans for Xen in Arch

The Xen package has been in AUR for some time and I am only the most recent maintainer for the package.  As of 2026-10, the package is still unlikely to make it into the repos.  While the build flags could be easily removed, we track the stable get repo to automatically get necessary security patches.  This obviously limits reproducability.  Also, I am not a maintainer and have only vague ideas about how to become one.

Xen in AUR is undergoing a bit of a (stalled as of October 2026) re-engineering with help from the community.  That work is happening in ``xen-next``, while the current AUR package exists in ``xen-aur``.   These instructions work for both versions.

