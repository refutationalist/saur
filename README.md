# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in acouple of cases, packages I'm maintaining in AUR.

Most of these packages are for use in my radio studio for shows including [Ask an Atheist with Sam Mulvey](https://atheist.radio), [Radio Tacoma KTAH-LP 101.9](http://radiotacoma.org), and [KTQA-LP](http://ktqa.org).

There's also a game I'm kind of addicted to.



## My Software
  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) -- my fork of `jack-peak` which can output to a web socket.
  * [systemjack-git](https://github.com/refutationalist/systemjack) -- a scaffold for building audio systems in Arch Linux using JACK and systemd
  * [dumpload](https://github.com/refutationalist/dumpload) -- a basic web file dump

## Standalone Packages

  * [qmeu-android-x86](https://aur.archlinux.org/packages/qemu-android-x86/) -- in AUR.  A method for simply running [Android-x86](http://android-x86.org) in QEMU with virgl and whatnot.  **In AUR.**
  * [silentjack](https://aur.archlinux.org/packages/silentjack) -- recently adodpted, not often updated, fairly stable software. **In AUR**
  * [JMPX](http://jontio.zapto.org/hda1/paradise/jmpxencoder/jmpx.html) -- an FM stereo (MPX) encoder with fun widgets
  * [wsServer](https://github.com/Theldus/wsServer) -- A rather simple websocket library.   Currently points to my fork that allows binding to localhost and basic IPv6 support.
  * [rimworld](https://rimworldgame.com/) -- the non-steam Rimworld package from AUR, with the ability to add Ideology and a simpler method of adding future DLCs
  * [jack_capture](https://github.com/refutationalist/jack_capture) -- This is my personal fork of jack_capture.  My changes have been merged but there hasn't been a release for them yet.  Use [jack_capture-git](https://aur.archlinux.org/packages/jack_capture-git) in AUR.
  
## Fonts
  * [perfect-vga](http://laemeur.sdf.org/fonts/) -- VGA fonts that I use in terminals that are useable, which as of 2020-08 does not include gnome-terminal or any modern VTE derived terminals.  I have feelings about this.
  * [ttf-vcr-eas](https://www.fontzip.com/vcr-eas) -- The font endemic to digital television systems in the 80s and 90s.  Used for weird things.

 
## Xen

 * [xen](https://aur.archlinux.org/packages/xen/) -- see below


I originally started working on a [Xen](https://xenproject.org) package for 4.13.1 and modern Arch because I needed a solution to keep working while others were working on upstreaming packages and (hopefully) getting Xen out of AUR and into the official repos, and I shared my work in the hopes of helping them out.  It didn't work out that way, and I find myself managing the AUR package.  I'm currently in the process of making the package fit for AUR and pushing the changes there.

  * xen is the Xen package itself.  The PKGBUILD is a kitbash of what's in AUR combined with FFY00's work, with some simplifications and things I've wanted added on.  It creates `xen` and `xen-docs` packages.
  * linux-pvh is a kernel installed on the dom0 for PVH.  As of May 2020, [PVH](https://wiki.xen.org/wiki/Xen_Project_Software_Overview#PVH_.28x86.29) only supports direct kernel booting, and this kernel provides that.   It is a vanilla kernel with modules and most drivers stripped out, the xenconfig defconfig applied, and stuff I used added directly to the kernel.  It does not require an initramfs, and nothing needs to be installed on a PVH domU.  Headers are compiled into the kernel for simplicty.  To use it, set `kernel = "/usr/share/linux-lts-pvh/kernel"` to your domU config.  It is a temporary thing until Xen's EFI booting method arrives.


