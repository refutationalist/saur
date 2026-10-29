# signal-rest

This is the Signal [REST-based API](https://github.com/bbernhard/signal-cli-rest-api/), that's cheap and cheerful front end (written in Go) to [signal-cli](https://github.com/AsamK/signal-cli) (written in Java) that uses [libsignal-client](https://aur.archlinux.org/packages/libsignal-client) (also written in Java).  Instead of a docker container, the REST broker and signal-cli run as simple systemd services.

## Configuring and Running signal-rest

Build and install [libsignal-client](https://aur.archlinux.org/packages/libsignal-client), [signal-cli-native](https://aur.archlinux.org/packages/signal-cli-native), and ```signal-rest```.  I suppose you could adapt this to run the java-native [signal-cli](https://aur.archlinux.org/packages/signal-cli), but that would sort of defeat the reason I did this in the first place.

I could not do registration with the REST API, so I ended up doing it on the command line before starting it.

Once packages are in, go like this at your shell:
```shell

# sudo -u signal-cli -s
$ cd
$ signal-cli --config=/var/lib/signal-cli link --name=$(hostname)

```

You can obviously change the hostname part to something more useful to you.  In recent signal-cli versions it will print a QR code right in the console.   If that doesn't work you can do the following with the "```sgnl://linkdevice...```" URL it gives you:

```shell

cd /tmp
qrencode -o link.png "<SGNL URL HERE>" && eog link.png

```

Assuming you have ```qrencode``` and ```eog``` installed, you'll get a QR image that you can use to link to a Signal device.  It's also possible to register completely new numbers, but I didn't do that so not in the docs.  I don't recommend it, either.  Once linked, the original ```signal-cli``` call will do some random stuff and then exit.   Congrats, your accounts are linked.  Next, back on the server running ```signal-rest```:

```shell

$ exit
# systemctl enable --now signal-cli-rpc.service
# systemctl enable --now signal-rest.service

```

If you've done things right, you now have the signal-rest REST broker running.   To test it, you can check out [the examples](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/EXAMPLES.md), and the [API documentation](https://bbernhard.github.io/signal-cli-rest-api/).   I'm still working on the service files, but they do run.

By default in this package, the rest API binds to the local interface.  You can change that as well as many other options in the ```/etc/conf.d/signal-rest.env.sh``` file.

## There's a patch.   What does it do?

  * If the broker asks for a container ID, it gets ```NOCONTAINER```.
  * It allows the passing of the config, attachment, and avatar directories via the environment to normalize configuration.  In this implementation, the attachment directory doesn't mean anything as we ignore attachments anyway.
  * Changes the way it binds to the network to allow it to bind to a specific address.   I use this to bind to localhost because the idea of depending on a firewall to prevent access to local resources is a *dreadful* antipattern.
 
Since this is beyond the purpose of the original author, I've no intention of submitting a patch.  I'm also, sort of... not at all a Go developer.  I'm mostly comfortable with all this because the modifications I made are very simple.

## So do you hate containers?  Why do this?

tl;dr: To run [Uptime Kuma](https://github.com/louislam/uptime-kuma) on a VPS with minimal resources.

With Uptime Kuma and the Signal API in containers I was eating over a gig of RAM, which was more than my original VPS could handle.   After de-containerizing I only need 300 meg or so.  Very doable on an extermely cheap VPS.

The best place to run a service like these are on resources that are **not** within the resources you are monitoring.  Otherwise, if the router goes down Uptime Kuma can't tell me.  This is obviously sub-optimal.

With the cheap VPS markets available on places like [Low End Spirit](https://lowendspirit.com/), I've got an independent system watching.  Hooray!

### Also, it broke.

The signal container died.   I couldn't find out why, and people with similar problems on GitHub solved it by deleting and recreating the container.   I mean, I get that's the point of containers and microservices.   But!  That doesn't **fix** it.  It's just an undo button on the state of the broker, and whatever ate the service is still in there, waiting to strike again.

That's not good for my anxiety.

To fix it, I started playing with signal-cli by hand, got that to work, and then started building and running the REST broker by hand to see where it broke.  Once I did that, I realized it was simpler just to build and run it outside of the container, and save RAM in the bargain.

So that's what I did.   So I guess I'm against containers?   At least how they're used out in the world.
