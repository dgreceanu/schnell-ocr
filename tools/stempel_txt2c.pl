#!/usr/bin/perl -w
use strict;
# annehmen, dass die eingangsdaten auf jedem Fall richtig ist

print "\nstruct zeichen_vektor daten_muster[] = {\n";

our ($name, $val, $i);

$name = <>;
chomp($name);
$i = 0;

while (1){
	$val = <>;
	chomp($val);
	$val =~ s/ /,/g;
	print '{"', $name, '", {', $val, "}";
	$i++;
	$name = <>;
	if (defined($name)) {
		print ",\n";
	} else {
		print "\n";
		last;
	}
	chomp($name);
}

print "};\n";

print "#define ZEICHEN_MUSTER_MENGE $i\n";