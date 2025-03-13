# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in a couple of cases, packages I'm maintaining in AUR.

Most of these packages are for my work at [KTQA-LP](http://ktqa.org), [KQWZ-LP](https://kqwzradio.org/), and the [Radio Club of Tacoma](https://w7dk.org).

There's also a game I'm kind of addicted to.



## My Stuff
  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) -- my fork of `jack-peak` which can output to a web socket.
  * [systemjack-git](https://github.com/refutationalist/systemjack) -- a scaffold for building audio systems in Arch Linux using JACK and systemd
  * [dumpload](https://github.com/refutationalist/dumpload) -- a basic web file dump

## Standalone Packages

  * [qmeu-android-x86](https://aur.archlinux.org/packages/qemu-android-x86/) -- A method for simply running [Android-x86](http://android-x86.org) in QEMU with virgl and whatnot.  **In AUR.**
  * [silentjack](https://aur.archlinux.org/packages/silentjack) -- recently adodpted, not often updated, fairly stable software. **In AUR.**
  * [wsServer](https://github.com/Theldus/wsServer) -- A rather simple websocket library.   Currently points to my fork that allows binding to localhost and basic IPv6 support.
  * [rimworld](https://rimworldgame.com/) -- the non-steam Rimworld package from AUR, with the ability to add Ideology and a simpler method of adding future DLCs
  * [jack_capture](https://github.com/refutationalist/jack_capture) -- This is my personal fork of jack_capture.  My changes have been merged but there hasn't been a release for them yet.  Use [jack_capture-git](https://aur.archlinux.org/packages/jack_capture-git) in AUR.
  
## Fonts
  * [perfect-vga](http://laemeur.sdf.org/fonts/) -- VGA fonts that I use in terminals that are useable, which as of 2020-08 does not include gnome-terminal or any modern VTE derived terminals.  I have feelings about this.
  * [ttf-vcr-eas](https://www.fontzip.com/vcr-eas) -- The font endemic to digital television systems in the 80s and 90s.  Used for weird things.

 
## The Xen Suite

> [!TIP]
> It is recommended to build Xen in a chroot or clean VM.  The build process can pick up unintended dependencies.

The major components are:

 * [xen](https://aur.archlinux.org/packages/xen/) -- the Xen virtualization platform packages
 * [xen-qemu](https://qemu.org) -- QEMU compiled for Xen
 * [xen-grub](https://www.gnu.org/software/grub/) -- GRUB packages compiled for Xen paravirtualization support
 * [xen-edk2](https://github.com/tianocore/edk2) -- A Xen compatible UEFI from the EDK II project 

All packages are required for full functionality.  There are optional build-time flags for some packages but are not recommended unless you know what you're doing. 

For operational information about Xen on Arch Linux, see [the Xen wiki page](https://wiki.archlinux.org/title/Xen) on the Arch Wiki.


### Building Xen

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


### QEMU for Xen

By itself, the ``xen`` package can run PVH domUs without graphical consoles and with only Xen paravirtualized interfaces.   For anything else, a special version of QEMU is required.

Xen support in QEMU has been upstreamed but the support isn't compiled into the QEMU in the Arch repositories.   This package adds that support, and is designed not to interfere with the QEMU in ```[extra]```.

### Booting domUs

In Xen parlance the hypervisor is called the **dom0**, and any virtual machines is a **domU**.

There are several methods of virtualization for Xen domUs:

  * PV (paravirtualization) is the original mode in Xen.
  * HVM virtualizes a complete computer with BIOS or UEFI and uses hardware virtualization extensions.
  * PVH is a paravirtualized machine inside of hardware virtualization.   Technically PVHv2, this method of virtualization provides a smaller attack surface and is under much development.   It does not yet support all features.

The boot HVM machines, you can boot BIOS or UEFI systems.   For BIOS, install [seabios](https://archlinux.org/packages/extra/any/seabios/).  To boot UEFI, ```xen-edk2``` is needed.

For PV and PVH machines, you'll need GRUB compiled specifically for that mode.   Alternatively, you can also pass your domU a specific kernel to boot on the ```kernel`` config line, but that means the kernel has to exist outside of the domU.

#### xen-grub

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


### Future Plans for Xen in Arch

The Xen package has been in AUR for some time and I am only the most recent maintainer for the package.  As of 2025-03, the package is a lot easier to manage but is still unlikely to make it into the repos.  While the build flags could be easily removed, the move to the stable git repo prevents reproduceable builds.

Xen in AUR is undergoing a bit of a re-engineering with help from the community.  That work is happening in ``xen-next``, while the current AUR package exists in ``xen-aur``.   These instructions work for both versions.
