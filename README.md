# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some of these are forks wanting a merge, modifications of modified software, or in a couple of cases, packages I'm maintaining in AUR.

Most of these packages are for my work at [KTQA-LP](http://ktqa.org), [KQWZ-LP](https://kqwzradio.org/), and the [Radio Club of Tacoma](https://w7dk.org).


## The Packages

### My Stuff

This is stuff of my own, or stuff that I've forked or patched mostly for radio station work.

  * [jack-webpeak](https://github.com/refutationalist/jack-webpeak) -- my fork of `jack-peak` which can output to a web socket.
  * [jackwsmix](https://github.com/refutationalist/jackwsmix) -- a websocket mixer for JACK, based on ```jack-minimix```.
  * [systemjack-git](https://github.com/refutationalist/systemjack) -- a scaffold for building audio systems in Arch Linux using JACK and systemd
  * [dumpload-git](https://github.com/refutationalist/dumpload) -- a basic web file dump, used to download raw studio recordings.
  * [jack_capture](https://github.com/refutationalist/jack_capture) -- This is my personal fork of jack_capture.  My changes are in git, but there hasn't been a release since 2017.  Use [jack_capture-git](https://aur.archlinux.org/packages/jack_capture-git) in AUR.
  * [logger](https://github.com/refutationalist/fdlogger) -- My simple Field Day logger, written in modern PHP with a significant javascript component.
  * [novnc-lighttpd](https://novnc.com/info.html) -- A simple way to add NoVNC as a webapp with minimal client-side decoration.



### Standalone Packages

Packages not in official repo's, and for one reason or another not in AUR.

  * [CODE](https://collaboraonline.github.io/) -- Collabora Online Development Environment, the online LibreOffice server used by NextCloud Office.
  * [lighttpd-dbi](https://www.lighttpd.net/) -- lighttpd compiled with a useful dbi plugin.
  * [rivendell](https://www.rivendellaudio.org/) -- Rivendell Radio Automation system.  Currently under testing at my station.
  * [silentjack](https://aur.archlinux.org/packages/silentjack) -- recently adodpted, not often updated, fairly stable software. **In AUR.**
  * [signal-rest](https://github.com/bbernhard/signal-cli-rest-api/) -- The [Signal](https://signal.org/) API required by many other services, dedockerized and made sane.
  * [systemd-netlogd](https://github.com/systemd/systemd-netlogd) -- The official systemd version of systemd-netlogd, which simply punts journal messages to a defined log server in a variety of ways.   My version fixed some problems with the AUR version, which the AUR version took on.  Use the AUR version.
  * [wsServer](https://github.com/Theldus/wsServer) -- A rather simple websocket library.


### Fonts

Fonts I use.

  * [perfect-vga](http://laemeur.sdf.org/fonts/) -- VGA fonts that I use in terminals that are useable, which as of 2020-08 does not include gnome-terminal or any modern VTE derived terminals.  I have feelings about this.
  * [ttf-vcr-eas](https://www.fontzip.com/vcr-eas) -- The font endemic to digital television systems in the 80s and 90s.  Used for weird things.

 
### Stuff Being Phased Out
 * [rimworld](https://rimworldgame.com/) -- the non-steam Rimworld package from AUR, with the ability to add Ideology and a simpler method of adding future DLCs
   * I'd like to keep working on this, but the number of quality of life mods needed basically demand a modmanager, and therefore Steam.

### Stuff That's Gone
 * [qmeu-android-x86](https://aur.archlinux.org/packages/qemu-android-x86/) -- A method for running [Android-x86](http://android-x86.org) like an app.   I've orphaned this project and have moved to Waydroid.

### Xen Packages

Packages used by the Xen virtualization suite.   Most of these packages are already in AUR.

 * [xen-aur](https://aur.archlinux.org/packages/xen/) -- the Xen kernel and support structure as it appears in AUR.
 * [xen-qemu](https://qemu.org) -- QEMU compiled for Xen
 * [xen-grub](https://www.gnu.org/software/grub/) -- GRUB packages compiled for Xen paravirtualization support
 * [xen-edk2](https://github.com/tianocore/edk2) -- A Xen compatible UEFI from the EDK II project
 * xen-next -- A significantly upgraded version of Xen, taking patches from other projects.   As of 05-2025, this effort is currently frozen.


## The Xen Suite

> [!TIP]
> It is recommended to build Xen in a chroot or clean VM.  The build process can pick up unintended dependencies.

All packages (save xen-next) are required for full functionality.  There are optional build-time flags for some packages but are not recommended unless you know what you're doing. 

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

In Xen parlance the hypervisor is called the **dom0**, and any virtual machine is a **domU**.

There are several methods of virtualization for Xen domUs:

  * PV (paravirtualization) is the original mode in Xen.
  * HVM virtualizes a complete computer with BIOS or UEFI and uses hardware virtualization extensions.
  * PVH is a paravirtualized machine inside of hardware virtualization.   Technically PVHv2, this method of virtualization provides a smaller attack surface and is under much development.   It does not yet support all features.

The boot HVM machines, you can boot BIOS or UEFI systems.   For BIOS, install [seabios](https://archlinux.org/packages/extra/any/seabios/).  To boot UEFI, ```xen-edk2``` is needed.

For PV and PVH machines, you'll need GRUB compiled specifically for that mode.   Alternatively, you can also pass a specific kernel to boot on the ```kernel``` config line, but that means the kernel has to exist outside of the domU.

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


## signal-rest

This is the Signal [REST-based API](https://github.com/bbernhard/signal-cli-rest-api/), that's cheap and cheerful front end (written in Go) to [signal-cli](https://github.com/AsamK/signal-cli) (written in Java) that uses [libsignal-client](https://aur.archlinux.org/packages/libsignal-client) (also written in Java).  Instead of a docker container, the REST broker and signal-cli run as simple systemd services.

### Configuring and Running signal-rest

Build and install [libsignal-client](https://aur.archlinux.org/packages/libsignal-client), [signal-cli-native](https://aur.archlinux.org/packages/signal-cli-native), and ```signal-rest```.  I suppose you could adapt this to run the java-native [signal-cli](https://aur.archlinux.org/packages/signal-cli), but that would sort of defeat the reason I did this in the first place.

I could not do registration with the REST API, so I ended up doing it on the command line before starting it.

Once packages are in, go like this at your shell:
```shell

# sudo -u signal-cli -s
$ cd
$ signal-cli --config=/var/lib/signal-cli link --name=$(hostname)

```

You can obviously change the hostname part to something more useful to you.   It will then spit out a URL that looks like: "```sgnl://linkdevice...```"  Copy that text and in a window on your own workstation, something like so:

```shell

cd /tmp
qrencode -o link.png "<SGNL URL HERE>" && eog link.png

```

Assuming you have ```qrencode``` and ```eog``` installed, you'll get a QR image that you can use to link to a Signal device.  It's also possible to register completely new numbers, but I didn't do that so not in the docs.  I don't reccommend it, either.  Once linked, the original ```signal-cli``` call will do some random stuff and then exit.   Congrats, your accounts are linked.  Next, back on the server running ```signal-rest```:

```shell

$ exit
# systemctl enable --now signal-cli-rpc.service
# systemctl enable --now signal-rest.service

```

If you've done things right, you now have the signal-rest REST broker running.   To test it, you can check out [the examples](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/EXAMPLES.md), and the [API documentation](https://bbernhard.github.io/signal-cli-rest-api/).   I'm still working on the service files, but they do run.

By default in this package, the rest API binds to the local interface.  You can change that as well as many other options in the ```/etc/conf.d/signal-rest.env.sh``` file.

### There's a patch.   What does it do?

  * If the broker asks for a container ID, it gets ```NOCONTAINER```.
  * It allows the passing of the config, attachment, and avatar directories via the environment to normalize configuration.  In this implementation, the attachment directory doesn't mean anything as we ignore attachments anyway.
  * Changes the way it binds to the network to allow it to bind to a specific address.   I use this to bind to localhost because the idea of depending on a firewall to prevent access to local resources is a *dreadful* antipattern.
 
Since this is beyond the purpose of the original author, I've no intention of submitting a patch.  I'm also, sort of... not at all a Go developer.  I'm mostly comfortable with all this because the modifications I made are very simple.

### So do you hate containers?  Why do this?

tl;dr: To run [Uptime Kuma](https://github.com/louislam/uptime-kuma) on a VPS with minimal resources.

With Uptime Kuma and the Signal API in containers I was eating over a gig of RAM, which was more than my original VPS could handle.   After de-containerizing I only need 300 meg or so.  Very doable on an extermely cheap VPS.

The best place to run a service like these are on resources that are **not** within the resources you are monitoring.  Otherwise, if the router goes down Uptime Kuma can't tell me.  This is obviously sub-optimal.

With the cheap VPS markets available on places like [Low End Spirit](https://lowendspirit.com/), I've got an independent system watching.  Hooray!

#### Also, it broke.

The signal container died.   I couldn't find out why, and people with similar problems on GitHub solved it by deleting and recreating the container.   I mean, I get that's the point of containers and microservices.   But!  That doesn't **fix** it.  It's just an undo button on the state of the broker, and whatever ate the service is still in there, waiting to strike again.

That's not good for my anxiety.

To fix it, I started playing with signal-cli by hand, got that to work, and then started building and running the REST broker by hand to see where it broke.  Once I did that, I realized it was simpler just to build and run it outside of the container, and save RAM in the bargain.

So that's what I did.   So I guess I'm against containers?   At least how they're used out in the world.

