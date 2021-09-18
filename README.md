# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in acouple of cases, packages I'm maintaining in AUR.

Most of these packages are for use in my radio studio for shows including [Ask an Atheist with Sam Mulvey](https://atheist.radio), [Radio Tacoma KTAH-LP 101.9](http://radiotacoma.org), and [KTQA-LP](http://ktqa.org).


## Highlights

  * [JMPX](http://jontio.zapto.org/hda1/paradise/jmpxencoder/jmpx.html) FM encoder
  * [qmeu-android-x86](https://aur.archlinux.org/packages/qemu-android-x86/) in AUR.  A method for simply running [Android-x86](http://android-x86.org) in QEMU with virgl and whatnot.
  * [libwebsock](https://github.com/JonnyWhatshisface/libwebsock) A really easy websocket library for C.
  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) my fork of `jack-peak` which can output to a web socket.  Requires the above package.
  * [perfect-vga](http://laemeur.sdf.org/fonts/) VGA fonts that I use in terminals that are useable, which as of 2020-08 does not include gnome-terminal or any modern VTE derived terminals.
  * [systemjack](https://github.com/refutationalist/systemjack) a scaffold for building audio systems in Arch Linux using JACK and systemd
  * [dumpload](https://github.com/refutationalist/dumpload) a basic web file dump
  * [xen](https://aur.archlinux.org/packages/xen/) -- see below
  * [linux-s0ix-git](https://gitlab.com/smbruce/linux-stable-s0ix) -- mainline linux with the AMD s0ix patches added, for my AMD laptops.  This probably goes away at 5.15.

## Xen

I originally started working on a [Xen](https://xenproject.org) package for 4.13.1 and modern Arch because I needed a solution to keep working while others were working on upstreaming packages and (hopefully) getting Xen out of AUR and into the official repos, and I shared my work in the hopes of helping them out.  It didn't work out that way, and I find myself managing the AUR package.  I'm currently in the process of making the package fit for AUR and pushing the changes there.

  * xen is the Xen package itself.  The PKGBUILD is a kitbash of what's in AUR combined with FFY00's work, with some simplifications and things I've wanted added on.  It creates `xen` and `xen-docs` packages.
  * qemu-xen is a modification of the QEMU package in the [repo](https://www.archlinux.org/packages/extra/x86_64/qemu/) that includes full Xen support. I'm not really keeping up on it as I've added building QEMU as an option in the xen PKGBUILD, and that suits me just fine for now.
  * linux-lts-pvh is a kernel installed on the dom0 for PVH.  As of May 2020, [PVH](https://wiki.xen.org/wiki/Xen_Project_Software_Overview#PVH_.28x86.29) only supports direct kernel booting, and this kernel provides that.   It is linux-lts from the repos with modules and most drivers stripped out, the xenconfig defconfig applied, and stuff I used added directly to the kernel.  It does not require an initramfs, and nothing needs to be installed on a PVH domU.  Headers are compiled into the kernel for simplicty.  To use it, set `kernel = "/usr/share/linux-lts-pvh/kernel"` to your domU config.  It is a temporary thing until Xen's EFI booting method arrives.

