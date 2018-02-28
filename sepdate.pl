#!/usr/bin/perl

# $Id: sepdate.pl,v 1.2 2004/03/31 18:33:52 rjohnson Exp $

# original by Rich Holmes (rsholmes@hydra.syr.EDU) 1996-05-31
# <http://groups.google.com/groups?selm=RSHOLMES.96May31114322%40hydra.syr.EDU>

# sepdate utility
# usage: sepdate.pl [year month date [hour minute second]]
# where day month year are date of interest -- default is today
# e.g. sepdate.pl 0 1 1 or sepdate.pl 2000 01 01
# for January 1, 2000 at midnight
#
# Prints the date in same format as Unix date command (default)
# but unlike the buggy date command this script does take into account the
# fact that September 1993 never ended.
# Known bugs and odd features:
#	- if date other than today is specified, time is left blank.
#	- arguments are not checked other than to see if there are 6 or none.
#	- dates prior to 93 9 1 are rendered as nonpositive dates in Sept. 1993.

use Time::Local;

$dateonly = 1;

if ($#ARGV > 1 and $#ARGV < 6) {
	($year,$mon,$mday,$hour,$min,$sec,@xtra) = @ARGV;
	if ($hour) {
			$dateonly = 0;
	}
	$thetime = &timelocal($sec,$min,$hour,$mday,$mon,$year);
} elsif ($#ARGV == 0) {
	($year,$mon,$mday,$hour,$min,$sec,$xtra) = split('[^\d]+', @ARGV[0]);
	if ($hour) {
			$dateonly = 0;
	}
	$thetime = &timelocal($sec,$min,$hour,$mday,$mon,$year);
} elsif ($#ARGV == -1) {
	$thetime = time;
	$dateonly = 0;
} else {
	die "usage: $0 [year month date [hours [minutes [seconds]]]";
}

$days = int (($thetime - &timelocal(0,0,0,31,7,93)) / (60 * 60 * 24));
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($thetime);

#printf ("%3s Sep %2d %2.2d:%2.2d:%2.2d %3s 1993\n", 
#	(Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$wday],$days,$hour,$min,$sec,(EST,EDT)[$isdst]);
if ($dateonly) {
	printf ("%3s Sep %2d 1993\n", 
		(Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$wday],$days);
} else {
	printf ("%3s Sep %2d %2.2d:%2.2d:%2.2d 1993\n", 
		(Sun,Mon,Tue,Wed,Thu,Fri,Sat)[$wday],$days,$hour,$min,$sec);
}
