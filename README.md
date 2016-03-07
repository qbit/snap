snap
====
OpenBSD upgrade script.

- [Changes](#changes)
- [Features](#features)
- [Usage](#usage)
- [.snaprc options and defaults](#snaprc-options-and-defaults)
- [Examples](#examples)
- [Sample .snaprc](#sample-snaprc)
- [Installation](#installation)
- [Verifying an Installation](#verifying-an-installation)
- [Releases vs master](#releases-vs-master)

Changes
=======
* 2016-02-03 : Add ability for snap to verify its integrity via [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html)!
* 2015-04-07 : Remove pv support as [ftp(1)](http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/ftp.1?query=ftp&arch=i386) can do the same job.
* 2015-03-25 : Add ability for snap to update itself and run installboot.
* 2014-09-26 : Pull in the fixes for etc and xetc set removal.

Features
========
* Verify integrity of the snap script itself.
* Upgrade to a release, or to snaps (Not recommended. Following faq/upgradeXX.html required!).
* Store config options in an rc file.
* Auto # cpu detection.
* Auto detection of arch type for arm: OMAP, IMX (needs love!).
* Signature verification of sets with [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html)

Usage
=====
*  -s force snap to use snapshots.
*  -S do not check signatures.
*  -c specify location of config file (default is ~/.snaprc)
*  -e just extract sets in DST.
*  -m \<machine\> use \<machine\> instead of what 'machine' returns.
*  -v \<version\> used to force snap to use \<version\> (examples: snapshots or 5.3).
*  -V \<setversion\> used to force snap to use \<setversion\> for sets (example: -V 5.3). Note: this will only append 53 to sets, ie base53.tgz.
*  -r run sysmerge after extracting {x}sets. (May dump core if the snapshots have introduced ABI changes. Not recommended.)
*  -x do not extract x11 sets.
*  -M specify a mirror to use (example: " -M ftp3.usa.openbsd.org")
*  -I [full path to SHA256.sig file] verify integrity of snap.
*  -i interactive with colors.
*  -n force using bsd.mp as bsd.
*  -k only install kernels and exit.
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
* **VER**: *uname -r*
* **CHK_UPDATE**: *false*
* **INS_UPDATE**: *false*
* **INSTBOOT**: ** (no default, set to disk that has bootstrap installed, sd0 for example)
* **REBOOT**: ** (no default, setting will cause a reboot once the upgrade is complete.)
* **MIRROR**: *ftp3.usa.openbsd.org*

Examples
========
  To update to the latest snapshot using an explicit mirror
  region:

    snap -s -M ftp3.usa.openbsd.org

  To update to the lastest version of 5.3 without updating xsets:

    snap -v 5.3 -V 5.3 -x -M ftp3.usa.openbsd.org

Sample .snaprc
==============

```
 INTERACTIVE:true
 DST:/tmp/upgrade
 MERGE:true
 MIRROR:ftp3.usa.openbsd.org
 NO_X11:true
```

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
- [keybase.io signed gist](https://gist.github.com/qbit/21b3bfc88f50ebf5bd2a) signed using [my account](https://keybase.io/qbit)
- [code.bolddaemon.com](http://code.bolddaemon.com/qbit/snap/src/master/snap.pub) the main repo for snap

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

