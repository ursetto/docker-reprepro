## Overview

Builds `ursetto/reprepro` Docker image on Ubuntu 18.04 base. Provides the reprepro command, for example for creating deb repositories from macOS. Also contains an example packaging target, and an example target for serving the repo.

## make package

`make package` is an example that will package all debs under `./deb` into `./repo`.
It is hardcoded to use `bionic/main`.

`./gpg` directory contains a gnupg HOME directory (your signing key).  apt repositories need to be signed, or you need to set `[trusted=yes]` in the client's `sources.list`.

    export GNUPGHOME=$(PWD)/gpg
    gpg --gen-key
    gpg --edit-key ID                  # addkey, if you want a signing subkey
    gpg --export --armor ID            # for the client

`gpg/` will be mounted under `/root/.gnupg` so that *reprepro* can access it.
You can also mount it somewhere else, and [set gnupghome in the repo](https://vincent.bernat.ch/en/blog/2014-local-apt-repositories#building-debian-packages).

Your repo `conf/distributions` should use `SignWith:` with your signing key ID. 

A basic repo would contain a single file `./repo/conf/distributions`, like:

    Codename: bionic
    Components: main
    Architectures: amd64
    SignWith: B8A9B427

