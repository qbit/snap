snap
====
OpenBSD upgrade script. 

Changes
=======
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
* -s force snap to use snapshots.
* -S do not check signatures.
* -c specify location of config file (default is ~/.snaprc)
* -e just extract sets in DST.
* -f force snap to use ftp sources (http is default).
* -a <arch> use <arch> instead of what is 'arch' returns.
* -m <machine> use <machine> instead of what 'machine -s' returns.
* -v <version> used to force snap to use <version> (examples: snapshots or 5.3).
* -V <setversion> used to force snap to use <setversion> for sets (example: -V 5.3). Note: this will only apend 53 to sets, ie base53.tgz
* -r run sysmerge after extracting {x}sets.
* -x do not extract x11 sets.
* -M specify a mirror to use (example: " -M ftp3.usa.openbsd.org")
* -i interactive with colors
* -n force using bsd.mp as bsd
* -k only install kernels and exit
* -B do not backup current kernel
* -h help

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
 PROTO:ftp
```
