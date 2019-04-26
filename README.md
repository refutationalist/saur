# Sam's AUR

This is a personal repo of packages for [Arch Linux](http://archlinux.org).  Some
of these are forks wanting a merge, modifications of modified software, or in a
couple of cases, packages I'm maintaining in AUR.

Most of these packages are for use in my radio studio for shows including
[Ask an Atheist with Sam Mulvey](https://atheist.radio), [Radio Tacoma KTAH-LP 101.9](http://radiotacoma.org), and [KTQA-LP](http://ktqa.org).


## Included Software

  * [JMPX](http://jontio.zapto.org/hda1/paradise/jmpxencoder/jmpx.html) FM encoder
  * [jack_capture](https://github.com/refutationalist/jack_capture), but with my patches my patches to set the name of the capture and set MP3 sample rate.
  * [sthttpd](https://github.com/refutationalist/sthttpd), fork of Jef Poskanzer's thttpd with my hacky php-cgi support for small systems.
  * mumble-jack-noconnect, a build of [mumble](https://wiki.mumble.info/wiki/Main_Page) with the jack patch, but the the autoconnection parts removed.
  * [darkice](http://www.darkice.org/), which is a working copy of what's in [AUR](https://aur.archlinux.org/packages/darkice/) but is here for completeness.
  * [k40whisperer](http://home.scorchworks.com/K40whisperer/k40whisperer.html) laser cutter software for stock K-40 cutters.


## Why Aren't You Putting k40-whisperer in AUR?

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


