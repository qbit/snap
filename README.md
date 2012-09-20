snap
====
OpenBSD upgrade script. 

Features
========
* Upgrade to a release, or to snaps.
* Store config options in an rc file.
* Smarts about virtualized hardware.
* Auto # cpu detection.

Usage
=====

*  -s force snap to use snapshots.
*  -c specify location of config file ( default is ~/.snaprc )
*  -f force snap to use ftp sources ( http is default ).
*  -a <arch> use <arch> instead of what is 'arch' returns.
*  -m <machine> use <machine> instead of what 'machine -s' returns.
*  -v <version> used to force snap to use <version> ( example: snapshots ).
*  -V <setversion> used to force snap to use <setversion> for sets ( example: 52 ).
*  -r run sysmerge after extracting {x}sets.
*  -x do not extract x11 sets.
*  -M specify a mirror to use ( example: " -M ftp3.usa.openbsd.org" )

*  -h help

*  -d debug

Sample .snaprc
==============

```
 DEBUG:true
 DST:/tmp/upgrade
 MERGE:true
 MIRROR:ftp3.usa.openbsd.org
 NO_X11:true
 PROTO:ftp
```
