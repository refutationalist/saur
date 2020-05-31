# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some
of these are forks wanting a merge, modifications of modified software, or in a
couple of cases, packages I'm maintaining in AUR.

Most of these packages are for use in my radio studio for shows including
[Ask an Atheist with Sam Mulvey](https://atheist.radio), [Radio Tacoma KTAH-LP 101.9](http://radiotacoma.org), and [KTQA-LP](http://ktqa.org).


## Included Software

  * [JMPX](http://jontio.zapto.org/hda1/paradise/jmpxencoder/jmpx.html) FM encoder
  * [jack_capture](https://github.com/refutationalist/jack_capture) **NOTE:** It's better to install the git package from [AUR](https://aur.archlinux.org/packages/jack_capture-git/) as my changes have been merged.  I'm keeping this here if I work on it again. 
  * [sthttpd](https://github.com/refutationalist/sthttpd), fork of Jef Poskanzer's thttpd with my hacky php-cgi support for small systems.
  * [qmeu-android-x86](https://aur.archlinux.org/packages/qemu-android-x86/) in AUR.  A method for simply running [Android-x86](http://android-x86.org) in QEMU with virgl and whatnot.
  * [libwebsock](https://github.com/JonnyWhatshisface/libwebsock) A really easy websocket library for C.
  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) my fork of `jack-peak` which can output to a web socket.  Requires the above package.
  * [nrsc5](https://github.com/theori-io/nrsc5) "HD Radio" decoding software for RTL-SDR

### Probably Don't Use
  * [k40whisperer](http://home.scorchworks.com/K40whisperer/k40whisperer.html) someone did the actual python work, so maybe use the one in [AUR](https://aur.archlinux.org/packages/k40whisperer/) instead.

## Xen

[Xen](https://xenproject.org) in [AUR](https://aur.archlinux.org/packages/xen/) is in a bit of a transitional state at the moment, that moment being May of 2020.  They're working to get patches upstream and more stuff included in the repos, which is a Very Good Thing that I'm looking forward to.   However, I'm using Xen right now and need to keep my systems up to date, so I created these packages in the meantime.   There are three packages:

  * xen is the Xen package itself.  The PKGBUILD is a kitbash of what's in AUR combined with FFY00's work, with some simplifications and things I've wanted added on.
  * qemu-xen is a modification of the QEMU package in the [repo](https://www.archlinux.org/packages/extra/x86_64/qemu/) that includes full Xen support.  Without it, Xen only works partially.
  * linux-lts-pvh is a kernel installed on the dom0 for PVH.  As of May 2020, [PVH](https://wiki.xen.org/wiki/Xen_Project_Software_Overview#PVH_.28x86.29) only supports direct kernel booting, and this kernel provides that.   It is linux-lts from the repos with modules and most drivers stripped out, the xenconfig defconfig applied, and stuff I used added directly to the kernel.  It does not require an initramfs, and nothing needs to be installed on a PVH domU.  Headers are compiled into the kernel for simplicty.  To use it, set `kernel = "/usr/share/linux-lts-pvh/kernel"` to your domU config.  It is a temporary thing until Xen's EFI booting method arrives.


## Removed Packages
  * [silentjack](https://aur.archlinux.org/packages/silentjack-git/) - someone else moved it into AUR.   Use that instead.
  * mumble-jack-noconnect, [mumble](https://wiki.mumble.info/wiki/Main_Page) supports JACK by default now, and even supports [no autoconnect](https://vis.nu/blog/disable_jack_autoconnect_in_mumble_1.3_and_later).
  * [darkice](http://www.darkice.org/), I stopped using it, and someone else took over [AUR](https://aur.archlinux.org/packages/darkice/).




## Why Didn't You Put k40whisperer in AUR?

    < sam> So, I've got this python app I'd like to package, and I'm not a python guy.   The code wants you to run it in the source directory.  Looks like a lot of people just dump that kind of stuff in /usr/share.   Is that the preferred way of doing it?
    < irc_person> there are guidelines: https://wiki.archlinux.org/index.php/Python_package_guidelines
    < sam> Yeah, read through them.   Don't seem to cover this kind of package.
    < helpful_person> /usr/share is absolutely not the right place for a python package
    < sam> Didn't really seem like it, which is why I'm asking.
    < helpful_person> is the software not available on the pypi?
    < sam> it is not.
    < helpful_person> if it is organized in a way that breaks every python convention then you're going to have to fight upstream and hack it into submission in the meantime
    < sam> Did you say, "dump it in /usr/share"?   Because that's what I heard.
    < helpful_person> !kill sam 
     * phrik beats sam with a 440BX motherboard until they slump to the ground.


