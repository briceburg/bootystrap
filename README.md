# bootystrap
briceburg's _system_ bootstrap :pirate_flag: :gift:

## notes

* systems get their own [branch](https://github.com/briceburg/bootystrap/branches), e.g. [archlinux](https://github.com/briceburg/bootystrap/tree/archlinux). NixOS branches are possible.
* idempotently configures a system -- managing packages, services, users, and core configuration. super helpful when installing a fresh OS! 
* provides the `gitbootystrap` command for managing "system dotfiles" (e.g. under /etc and /usr/local/bin).
* also provides the `gitbooty` command for managing "user dotfiles" (see the [booty repository](https://github.com/briceburg/booty)).


## usage

fork and modify to your needs.

* briceburg's archlinux
  ```sh
  bash <(curl https://raw.githubusercontent.com/briceburg/bootystrap/archlinux/usr/local/bin/bootystrap)
  ```

once bootstapped, the `gitbootystrap` command is used to manage "dotfiles" in this repository. the system can be re-bootystapped by running `bootystrap` without the need for curl.

### gitbootystrap

gitbootystrap is functionally equivalent to `gitbooty` from the [booty repository](https://github.com/briceburg/booty) with the execption that it is used to manage system files outside a user's home directory, e.g. /etc/foo/main.conf, /etc/skel/foo, &c.

:bulb: **use `gitbootystrap` as you would `git`**.

#### add a new dotfile

```sh
gitbootystrap add /path/to/new-file
gitbootystrap commit -m "adding new-file" && gitbootystrap push origin HEAD
```

#### update dotfiles

```sh
# check for local changes
gitbootystrap status
gitbootystrap pull
```

## TODO

* combine gitbooty and gitbootystrap command; when gitbooty is run as root, treat it as if it were gitbootystrap.