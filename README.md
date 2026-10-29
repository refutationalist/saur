# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in a couple of cases, packages I'm maintaining in AUR.

Most of these packages are for my work at [KTQA-LP](http://ktqa.org), [KQWZ-LP](https://kqwzradio.org/), and the [Radio Club of Tacoma](https://w7dk.org).


## The Packages

### My Stuff

This is stuff of my own, or stuff that I've forked or patched mostly for radio station work.

  * [alvin](https://lpfm.io/sam/alvin) the **a**rch **l**inux **v**irtual **in**staller, a method for quickly creating arch virtual machines and declaratively defining systems.  Under heavy development.
  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) -- my fork of `jack-peak` which can output to a web socket.
  * [jackwsmix](https://github.com/refutationalist/jackwsmix) -- a websocket mixer for JACK, based on ```jack-minimix```.
  * [systemjack-git](https://github.com/refutationalist/systemjack) -- a scaffold for building audio systems in Arch Linux using JACK and systemd
  * [dumpload-git](https://github.com/refutationalist/dumpload) -- a basic web file dump, used to download raw studio recordings.
  * [jack_capture](https://github.com/refutationalist/jack_capture) -- This is my personal fork of jack_capture.  My changes are in git, but there hasn't been a release since 2017.  Use [jack_capture-git](https://aur.archlinux.org/packages/jack_capture-git) in AUR.
  * [logger](https://github.com/refutationalist/fdlogger) -- My simple Field Day logger, written in modern PHP with a significant javascript component.
  * [novnc-lighttpd](https://novnc.com/info.html) -- A simple way to add NoVNC as a webapp with minimal client-side decoration.
  * lxqt-vnc -- a naive way to launch [labwc](https://github.com/labwc/labwc), [lxqt](https://lxqt-project.org/), and [wayvnc](https://github.com/any1/wayvnc) in a systemd user session, for the above.



### Standalone Packages

Packages not in official repo's, and for one reason or another not in AUR.

  * [CODE](https://collaboraonline.github.io/) -- Collabora Online Development Environment, the online LibreOffice server used by NextCloud Office.
  * [lighttpd-dbi](https://www.lighttpd.net/) -- lighttpd compiled with a useful dbi plugin.
  * [rivendell](https://www.rivendellaudio.org/) -- Rivendell Radio Automation system.  Currently under testing at my station.
  * [silentjack](https://aur.archlinux.org/packages/silentjack) -- recently adodpted, not often updated, fairly stable software. **In AUR.**
  * [signal-rest](https://github.com/bbernhard/signal-cli-rest-api/) -- The [Signal](https://signal.org/) API required by many other services, dedockerized and made sane.  [Further documentation is here.](signal-rest/README.md)
  * [systemd-netlogd](https://github.com/systemd/systemd-netlogd) -- The official systemd version of systemd-netlogd, which simply punts journal messages to a defined log server in a variety of ways.   My version fixed some problems with the AUR version, which the AUR version took on.  Use the AUR version.
  * [wsServer](https://github.com/Theldus/wsServer) -- A rather simple websocket library.


### Fonts

Fonts I use.

  * [perfect-vga](http://laemeur.sdf.org/fonts/) -- VGA fonts that I use in terminals that are useable, which as of 2020-08 does not include gnome-terminal or any modern VTE derived terminals.  I have feelings about this.
  * [ttf-vcr-eas](https://www.fontzip.com/vcr-eas) -- The font endemic to digital television systems in the 80s and 90s.  Used for weird things.

### Xen Packages

Packages used by the Xen virtualization suite.   Most of these packages are already in AUR.

 * [xen-aur](https://aur.archlinux.org/packages/xen/) -- the Xen kernel and support structure as it appears in AUR.
 * [xen-qemu](https://qemu.org) -- QEMU compiled for Xen
 * [xen-grub](https://www.gnu.org/software/grub/) -- GRUB packages compiled for Xen paravirtualization support
 * [xen-edk2](https://github.com/tianocore/edk2) -- A Xen compatible UEFI from the EDK II project
 * xen-next -- A significantly upgraded version of Xen, taking patches from other projects.   As of 05-2025, this effort is currently frozen.

### Other, in AUR

This section will likely expand.

  * [gnome-shell-extension-utcclock-git](https://github.com/injcristianrojas/UTCClock) -- show current UTC time in GNOME topbar


## The Xen Suite

Information about Xen has moved to [XEN.md](XEN.md).


