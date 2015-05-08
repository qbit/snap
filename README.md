snap
====
OpenBSD upgrade script.

Changes
=======
* 2015-04-07 : Remove pv support as [ftp(1)](http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man1/ftp.1?query=ftp&arch=i386) can do the same job.
* 2015-03-25 : Add ability for snap to update itself and run installboot.
* 2014-09-26 : Pull in the fixes for etc and xetc set removal.

Features
========
* Upgrade to a release, or to snaps.
* Store config options in an rc file.
* Auto # cpu detection.
* Auto detection of arch type for arm: OMAP, IMX.
* Signing support with [signify(1)](http://www.openbsd.org/cgi-bin/man.cgi?query=signify&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html)

Installation
============

``` sh
ftp https://raw.github.com/qbit/snap/master/snap
sudo install -m 755 snap /usr/local/bin
```

Usage
=====
*  -s force snap to use snapshots.
*  -S do not check signatures.
*  -c specify location of config file (default is ~/.snaprc)
*  -e just extract sets in DST.
*  -a <arch> use <arch> instead of what 'arch' returns.
*  -m <machine> use <machine> instead of what 'machine' returns.
*  -v <version> used to force snap to use <version> (examples: snapshots or 5.3).
*  -V <setversion> used to force snap to use <setversion> for sets (example: -V 5.3). Note: this will only append 53 to sets, ie base53.tgz.
*  -r run sysmerge after extracting {x}sets.
*  -x do not extract x11 sets.
*  -M specify a mirror to use (example: " -M ftp3.usa.openbsd.org")
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
* **MERGE**: *false*
* **NO_X11**: *false*
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
