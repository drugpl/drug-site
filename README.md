# About

This is the app that powers http://drug.org.pl site. Feel free to improve it or adapt to your needs. We appreciate your contributions!

# Development setup

OAuth applications (github, facebook) assume that app works under `http://drug.dev` url.

## OSX with Pow

That's easy. Symlink app under `drug`, copy `.env` to `.powenv` and you're done. The shortcut:

    bundle exec rake setup:pow
    bundle exec rake db:setup

## OSX or Linux with Foreman

First you'll need to get `dnsmasq` running with `drug.dev` pointing to `127.0.0.1`. Make sure your resolver picks up new DNS server (i.e. add dnsmasq to `resolv.conf`). Next you'll have to serve app from port `80` which isn't straithforward with non-root privileges. You can either use `authbind` or redirect on firewall from port `80` to other unprivilegded port app is listening on.

Another option is messing with browser and [PAC](http://en.wikipedia.org/wiki/Proxy_auto-config#The_PAC_file).

Put simply, lots of effort. It may be better just to configure your own OAuth apps with callbacks to `http://localhost:3000` instead.

After all this dance:

    bundle exec rake setup:default
    bundle exec rake db:setup
    bundle exec foreman start

## Vagrant

This would be the simplest and ultimate way for anyone. Needs your contribution!
