snap
====
OpenBSD upgrade script.

- [Features](#features)
- [Changes](#changes)
- [Usage](#usage)
- [.snaprc options and defaults](#snaprc-options-and-defaults)
- [Examples](#examples)
- [Sample .snaprc](#sample-snaprc)
- [Installation](#installation)
- [Verifying an Installation](#verifying-an-installation)
- [Releases vs master](#releases-vs-master)

Features
========
* Upgrade an OpenBSD-current machine to the latest snapshots. (Following [faq/current.html](https://www.openbsd.org/faq/current.html) still needs to be done!)
* Verify integrity of sets and the snap script itself using [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html).
* Configure via CLI flags or config options in an rc file.

Changes
=======
* 2016-07-15 : Fix armv7. Now working without umg files.
* 2016-02-03 : Add ability for snap to verify its integrity via [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html)!
* 2015-04-07 : Remove pv support as [ftp(1)](http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/ftp.1?query=ftp&arch=i386) can do the same job.
* 2015-03-25 : Add ability for snap to update itself and run installboot.
* 2014-09-26 : Pull in the fixes for etc and xetc set removal.

Usage
=====
*  -s force snap to use snapshots.
*  -S do not check signatures.
*  -c specify location of config file (default is ~/.snaprc)
*  -e just extract sets in DST.
*  -d just download sets to DST, verify and exit.
*  -m <machine> use <machine> instead of what 'machine' returns.
*  -V <setversion> used to force snap to use <setversion> for sets (example: -V 5.3). Note: this will only append 53 to sets, ie base53.tgz.
*  -r run sysmerge after extracting {x}sets. (May dump core if the snapshots have introduced ABI changes. Not recommended.)
*  -x do not extract x11 sets.
*  -M specify a mirror to use (example: " -M ftp3.usa.openbsd.org")
*  -I [full path to SHA256.sig file] verify integrity of snap.
*  -i interactive with colors.
*  -n force using bsd.mp as bsd.
*  -k only install kernels and exit.
*  -K install only the sets without the kernel.
*  -B do not backup current kernel.
*  -u check for update to snap script.
*  -U download new snap script (will replace currently installed version).
*  -b device to install bootstrap to.
*  -R reboot after installation.
*  -h help.

.snaprc options and defaults
=======
* **INTERACTIVE**: *false*
* **DST**: */tmp/upgrade*
* **EXTRACT_ONLY**: *false*
* **FTP_OPTS**: *-V*
* **MERGE**: *false*
* **NO_X11**: *false*
* **VER**: *"uname -r*
* **CHK_UPDATE**: *false*
* **INS_UPDATE**: *false*
* **INSTBOOT**: *(no default, set to disk that has bootstrap installed, sd0 for example)
*
* **REBOOT**: *(no default, setting will cause a reboot once the upgrade is complete.)*
* **AFTER**: *false*
* **MIRROR**: *(no default) script to be copied to `/etc/rc.firsttime`. This script should be kept in a safe place!*

Examples
========
  To upgrade to the latest snapshots:

    $ doas snap

  To update to the latest snapshot using an explicit mirror
  region:

    $ doas snap -M ftp3.usa.openbsd.org

  To update to the snapshot without updating xsets:

    $ doas snap -x

  When a new beta is cut, the system version jumps from X.Y to X.Z.
  When this happens, snap will need to be told what the new version
  is:

    $ doas snap -V 6.1

Sample .snaprc
==============

```
 INTERACTIVE:true
 DST:/tmp/upgrade
 MERGE:true
 MIRROR:ftp3.usa.openbsd.org
 NO_X11:true
```

Sample AFTER script
===================

Stored in `/etc/after_snap` with 0600 permissions.
```
#!/bin/sh
(
    cd /dev && sh MAKEDEV all
    /usr/sbin/fw_update -v
    /usr/sbin/pkg_add -um # -m is needed to see progress in this context
)    
```

Line from `~/.snaprc` would look like this: `AFTER:/etc/after_snap`

Installation
============

```
# make install
```

Verifying an Installation
=========================

**WARNING: I have had to create new keys for signing snap. Please update your pub key!**

`snap` now can be verified via [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html)!

The public key is as follows:

```
untrusted comment: github.com/qbit/snap public key
RWQVGN6sUjQQA5uYpANGLLKQMAERZ43otLePFSVqNFGGtf/qBez7G1WU
```

The old public key is:
```
untrusted comment: github.com/qbit/snap public key
RWTKOAnI3kqGqY/1ungBemfzkDj4ImXuybf4sDZcCrNJywffIRDkK1qF
```

The old old public key is:

```
untrusted comment: github.com/qbit/snap public key
RWQkqrbMjoywaLwJQf45TjtCLgtFPSEO7v/TBf01WRZjvl8NSy6rJ6Fe
```

Verification of the signature can be done with the following command (once the above key is added to `/etc/signify/snap.pub`):

```
snap -I
```

or

```
signify -C -p /etc/signify/snap.pub -x SHA256.sig snap
```

But Aaron, how do I know I have the correct public key? Mirrors.

The key is also available on the following locations:

Pub Key:
- [deftly.net](https://deftly.net/snap.pub)
- [cobug.org](https://cobug.org/snap.pub)
- [keybase.io signed gist](https://gist.github.com/qbit/17ecad885b7df7ec910ebcd4341852fa) signed using [my account](https://keybase.io/qbit)
- [code.bolddaemon.com](http://code.bolddaemon.com/qbit/snap/src/master/snap.pub) the main repo for snap
- [pgp signed gist](https://gist.github.com/qbit/abc5372d20995b25dc5a4b18c44e1441) signed using [gpg key](https://pgp.mit.edu/pks/lookup?op=get&search=0x1F81112D62A9ADCE)

Old pub key:
- [deftly.net](https://deftly.net/snap.pub.old)
- [cobug.org](https://cobug.org/snap.pub.old)
- [keybase.io signed gist](https://gist.github.com/qbit/1c4884883c38c79ce24d) signed using [my account](https://keybase.io/qbit)

Old old pub key:
- [deftly.net](https://deftly.net/snap.pub.old.old)
- [cobug.org](https://cobug.org/snap.pub.old.old)
- [keybase.io signed gist](https://gist.github.com/qbit/b0ed7d7cb6bac6b5afaf) signed using [my account](https://keybase.io/qbit)

Releases vs master
==================

You can run snap in `release` or `master` mode. `release` means the version string in the snap script is set to a number. `master`
means it contains "master".

The difference comes to light when doing upgrades, `-U` on a release will only upgrade to newer releases, while `master` will
always download the latest snap from the master branch. Both are signed and can be verified with the `-I` option.

`master` is to be considered experimental - similar to snapshots on OpenBSD. Experimental features will occasionally show up
here, but breakage should be minimal (I don't push to master until I have tested).
