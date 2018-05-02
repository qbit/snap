SNAP(8) - System Manager's Manual

# NAME

**snap** - snapshot upgrade tool

# SYNOPSIS

**snap**
\[**-BdehiIkKnrRsSuUx**]
\[**-b**&nbsp;\[device]]
\[**-c**&nbsp;\[config\_file]]
\[**-D**&nbsp;\[destination]]
\[**-m**&nbsp;\[machine]]
\[**-M**&nbsp;\[mirror]]
\[**-V**&nbsp;\[version]]

# DESCRIPTION

**snap**
is a
ksh(1)
script designed to upgrade an
OpenBSD
machine to the latest snapshot available.
Upgrading from release to release is not supported.

**snap**
checks the \`BUILDINFO\` file located on the remote mirror, and will
warn you if the snapshot is not newer than the currently running
version.

By default
**snap**
verifies signatures for the set files it downloads.
This can be prevented by specifying the
**-S**
option, however, skipping verification is very much not recommended!

The options are as follows:

**-D** *destination*

> Destination directory to place the \`.tgz\` files.

**-S**

> Skip signature verification.
> This is not recommended!

**-c** *config\_file*

> Location of configuration file (default is
> *$HOME/.snaprc*
> ).

**-e**

> Extract sets into destination directory and exit.
> The destination directory can be overwritten by the
> **-D**
> option, or by setting the DST line in
> *$HOME/.snaprc*.

**-d**

> Download sets to the destination directory, verify (
> **-S**
> prevents signature verification) and
> exit.
> By default the destination directory is set to
> */tmp/upgrade*

**-m** *machine*

> Use
> **machine**
> instead of what the \`machine\` command returns.

**-V** *setversion*

> Use to specify a specific version of sets.
> This option will need to be used when there is a version jump, say from 6.0 to 6.1.

**-r**

> Run sysmerge after extracting {x}sets.
> This option may cause issues if the newer snapshot introduces ABI changes.
> Not recommended.

**-x**

> Do not extract x11 sets.

**-M** *mirror*

> Specify which mirror to use.

**-I** *sigfile*

> Verify integrity of the
> **snap**
> tool.
> If
> **sigfile**
> is omitted,
> **snap**
> will pull a copy of SHA256.sig from the GitHub page.

**-i**

> Run in interactive mode (has colors).

**-n**

> Force snap to install
> **bsd.mp**
> as
> */bsd*

**-k**

> Only install the kernels and exit.

**-B**

> Prevent
> **snap**
> from making a backup of the kernel files.

**-u**

> Check for update to the
> **snap**
> script.

**-U**

> Download and install the latest version of
> **snap**
> (will overwrite currently installed version).
> Signature verification is also done.

**-b** *device*

> Tells
> **snap**
> which
> **device**
> to install bootstrap on.

**-R**

> Reboot after running
> **snap**

**-h**

> Help.

# FILES

*$HOME/.snaprc*

> Contains configuration options.
> See
> *SNAPRC*
> for more information on these options.

# SNAPRC

**snap**
supports the following configuration options via the
*$HOME/.snaprc*
file:

**INTERACTIVE bool**

> If true,
> **snap**
> will operate as if
> **-i**
> was specified.
> Defaults to false.

**DST directory**

> Tells
> **snap**
> where to download the snapshot sets and signature files.
> Defaults to
> */tmp/upgrade*

**EXTRACT\_ONLY bool**

> Tells
> **snap**
> to exit after extracting the sets.
> Defaults to false.

**FTP\_OPTS string**

> Lets you overwrite the options passed to
> ftp(1).
> This can be handy if your mirror supports file continuation!
> Defaults to: " -V ".

> See
> ftp(1)
> for options.

**MERGE bool**

> Tells
> **snap**
> to merge files in
> */etc*
> using the
> sysmerge(8)
> utility.
> Defaults to false.

**NO\_X11 bool**

> Tells
> **snap**
> to forgo download and extraction of xsets.
> Defaults to false.

**REBOOT bool**

> Setting this to \`true\` will cause
> **snap**
> to reboot the system after successful extraction of sets.
> Defaults to false.

**AFTER script**

> Specifies a script to be copied to
> */etc/rc.firsttime*.
> The script will then be executed upon successful reboot.
> Default is not set.

**MIRROR string**

> Defaults to \`cdn.openbsd.org\`.

# EXAMPLES

## EXAMPLE USAGE

To upgrade to the latest snapshot:

	$ doas snap

To upgrade to the latest snapshot using an explicit mirror region:

	$ doas snap -M cdn.openbsd.org

To upgrade to a snapshot without updating xsets:

	$ doas snap -x

## EXAMPLE SNAPRC

A typical
*~/.snaprc*
would look something like this:

	INTERACTIVE:true
	MERGE:true
	AFTER:/etc/after_snap
	MIRROR:cdn.openbsd.org
	FTP_OPTS:-C -V

## EXAMPLE AFTER SCRIPT

Here is an \`AFTER\` script that makes sure we have the latest devices
in
*/dev*,
upgrades all the firmware currently installed and upgrades currently
installed packages:

	#!/bin/sh
	(
	    cd /dev && sh MAKEDEV all
	    /usr/sbin/fw_update -v
	    /usr/sbin/pkg_add -uVm # -m is needed to see progress in this context
	)

# SIGNATURE VERIFICATION

**snap**
can be verified using the
**signify**
utility.

## Public key

	untrusted comment: github.com/qbit/snap public key
	RWQVGN6sUjQQA5uYpANGLLKQMAERZ43otLePFSVqNFGGtf/qBez7G1WU

## SIGNATURE URL

	https://raw.githubusercontent.com/qbit/snap/master/SHA256.sig

After installing the above public key in
*/etc/signify/snap.pub*
and downloading the
*SHA256.sig*
file, you can verify
**snap**
by running one the following:

Have snap download the
*SHA256.sig*
file and run verification:

	$ snap -I

Have snap verify a pre-downloaded
*SHA256.sig*
file:

	$ snap -I SHA256.sig

Manual verification with the
**signify**
utility:

	$ signify -C -p /etc/signify/snap.pub -x SHA256.sig snap

# SEE ALSO

ftp(1),
signify(1),
installboot(8),
rc(8),
release(8),
sysmerge(8)

# HISTORY

The first version of
**snap**
was released in September of 2012.

# AUTHORS

**snap**
was written by
Aaron Bieber &lt;[aaron@bolddaemon.com](mailto:aaron@bolddaemon.com)&gt;.

OpenBSD 6.2 - September 19, 2012
