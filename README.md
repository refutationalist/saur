# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in a couple of cases, packages I'm maintaining in AUR.

Most of these packages are for use in my radio studio for shows including [Ask an Atheist with Sam Mulvey](https://atheist.radio), [Radio Tacoma KTAH-LP 101.9](http://radiotacoma.org), and [KTQA-LP](http://ktqa.org).

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

 
## Xen

The ``xen`` package follows the stable git branch (currently ``stable-4.19``) rather than the release tarball.  This follows Xen security best-practices and also simplfies security patching.  The PKGBUILD is split and will create the main ``xen`` package and a ``xen-docs`` documentation package.  If stubdom is enabled, a ``xen-stubdom`` package will be built.

As of 2024-12, Xen in AUR is undergoing a bit of a re-engineering with help from the community.  That work is happening in ``xen-next``, while the original package as it is in AUR exists in ``xen-aur``.   The following instructions work for both versions.

 * [xen](https://aur.archlinux.org/packages/xen/) -- the Xen virtualization platform 
 * [xen-qemu](https://qemu.org) -- QEMU compiled for Xen
 * [xen-pvhgrub](https://www.gnu.org/software/grub/) -- GRUB2 compiled for Xen PVH support

### Building Xen

> [!WARNING]
> As of 2024-05, build_stubdom does not function.

It is recommended to build Xen packages in a clean VM or chroot.   Xen is a split package, and there are several options to building Xen:

  1) ``build_stubdom`` -- Build the components to run Xen stubdoms, mainly for [dom0 disaggregation](https://wiki.xenproject.org/wiki/Dom0_Disaggregation).  Components for stubdom are broken off into ``xen-stubdom`` if built.  Defaults to false.
  2) ``boot_dir``-- Your boot directory.  Defaults to ``/boot``.
  3) ``efi_dir``, ``efi_mountpoint`` -- Your EFI directory and mountpoint.   Defaults to ``/boot``.

Pass these arguments to makepkg as variables:

```
$ build_stubdom=true efi_dir="/boot/EFI" makepkg
```

If you build stubdom, note that it brings in a number of other components.   


### QEMU for Xen

*Attention Conservation Notice:* Build and install this package if you're running Xen on Arch.

If you want to run PV or HVM domU's, PCI passthrough, or even VNC consoles on your PVH domU's, you need QEMU.  ``xen-qemu`` provides a QEMU compatible with Xen.   On the other hand, if you're running basic domUs in a PVH environment, QEMU is not needed.  But you'll probably want it anyway.

Xen support in QEMU has been upstreamed for quite some time but QEMU in ``[extra]`` does not support it, as building it requires Xen libraries.  We have previously depended on a builtin version of QEMU that Xen builds, but it lags behind QEMU official and is difficult to patch.  As of 4.16.2, we now build QEMU for Xen separately.  The build options are pulled directly from Xen's built-in build and are designed to not interfere with QEMU from ``[extra]``.


### xen-pvhgrub

PVH is the new virtualization method and has a number of advantages.  This package is a version of GRUB2 that will allow a PVH domU to boot kernels installed inside the domU.   Instructions are available in the package directory.

### Future Plans for Xen in Arch

The Xen package has been in AUR for some time and I am only the most recent maintainer for the package.  As of 2022-08, I'd have to jump through a lot of hoops to get Xen into the repos so it's not a target.  That said, I'm trying to set things up so that bringing the packages into the repositories would not be too onerous.  Splitting QEMU off is a step forward, but moving to the stable branch in git might be a step back as the builds are less reproducable.  Pinning the build to a specific commit may help.  Also, signed commits from upstream would be good as we lost the ability to test the tarball against a GPG cert.

The support for stubdoms from upstream is questionable, and several maintainers have attempted to phase out the support.  My comporomise has been to split stubdom off into a separate package.  As PVH gets support for things like PCI or GPU passthrough, the need for stubdom will become much smaller.

